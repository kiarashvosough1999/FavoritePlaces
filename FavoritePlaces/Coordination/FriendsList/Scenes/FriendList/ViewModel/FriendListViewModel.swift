//
//  FriendListViewModel.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import UIKit
import CoreData

final class FriendListViewModel: NSObject, MVVMViewModel, DiffableDataSourceProvider {

    weak var coordinatorDelegate: FriendsCoordinationDelegate?
    
    // MARK: - Computed
    
    var title: String {
        .localize(.friends_List).uppercased()
    }
    
    // MARK: - Closure Binding
    
    @MainQueue2 var applySnapShot: SnapshotApplier?
    
    var takeSnapShot: SnapshotTaker?
    
    // MARK: - LifeCycle
    
    fileprivate let dependencies: FriendListViewModelDependencyProvider
    
    init(dependencies:FriendListViewModelDependencyProvider) {
        self.dependencies = dependencies
    }
    
    func setupInitialdataSource() {
        
        let repo = dependencies.repository
        
        repo.onContentChangedSnapshot = { [weak self, weak repo] snapshot in
            guard let strongSelf = self, let repo = repo else { return }
            
            var snapShot = SnapShot()
            
            snapShot.appendSections([.MyFriends])
            
            
            let items = repo
                .fetchResults()
                .or([])
                .compactMap { $0.toObject() }
                .compactMap { DataSourceItem.friend(model: $0) }
            
            snapShot.appendItems(items)
            
            strongSelf.$applySnapShot.execute(snapShot, true)
        }
        
        try? repo.performFetchWithFRC()
    }
    
    @objc func userDidTapedAdd() {
        coordinatorDelegate?.shouldAddFriend()
    }
    
    @objc func userDidTapedDelete() {
        try? dependencies.repository.deleteAllUser()
    }
    
    func didDeleteItem(at indexPath: IndexPath) {
        let repository = dependencies.repository
        try? repository.deleteObject(at: indexPath)
    }
    
    func didEditItem(at indexPath: IndexPath) {
        guard let item: AddFriendPersonModel = dependencies
            .repository
            .object(at: indexPath)
            .toObject() else { return }
        coordinatorDelegate?.shouldEditFriend(with: item)
    }
}

// MARK: - DiffableDataSource

extension FriendListViewModel {
    
    enum DataSourceSection: String, Hashable, CaseIterable {
        case MyFriends
    }
    
    enum DataSourceItem: Hashable {
        case friend(model: FriendListPersonModel)
    }
}

// MARK: - DI

protocol FriendListViewModelDependencyProvider {
    var repository: FriendListRepository { get }
}
