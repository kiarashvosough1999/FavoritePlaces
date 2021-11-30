//
//  SelectableFriendListViewModel.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import CoreData
import UIKit

final class SelectableFriendListViewModel: NSObject, MVVMViewModel, DiffableDataSourceProvider {
    
    // MARK: - Properties
    
    weak var coordinatorDelegate: SelectableFriendListCoordination?
    
    var title: String {
        .localize(.choose_friend).uppercased()
    }
    
    fileprivate var fetchResultController: NSFetchedResultsController<Person> {
        dependencies.personStore.fetchedResultsController
    }
    
    fileprivate var databaseContext: NSManagedObjectContext {
        dependencies.personStore.fetchedResultsController.managedObjectContext
    }
    
    fileprivate lazy var selectedFriends: [SelectPersonModel] = []
    
    // MARK: - Closure Binding
    
    @MainQueue2 var applySnapShot: SnapshotApplier?
    
    var takeSnapShot: SnapshotTaker?
    
    // MARK: - LifeCycle
    
    fileprivate let dependencies: SelectableFriendListViewModelDependencyProvider
    
    init(dependencies: SelectableFriendListViewModelDependencyProvider) {
        self.dependencies = dependencies
    }
    
    // MARK: - Impl
    
    func setupInitialdataSource() {
        dependencies.personStore.sortDescriptors = [NSSortDescriptor(keyPath: \Person.dateAdded, ascending: false)]
        
        dependencies.personStore.fetchedResultsController.delegate = self
        
        try? dependencies.personStore.fetchedResultsController.performFetch()
    }
    
    @objc func userDidTapedAdd() {
        coordinatorDelegate?.shouldAddFriend()
    }
    
    func didSelectedRow(with indexPath: IndexPath) {
        
        guard var item: SelectPersonModel = dependencies
                .personStore
                .fetchedResultsController
                .object(at: indexPath)
                .toObject() else { return }
        
        if selectedFriends.contains(item) {
            selectedFriends.removeAll(where: { $0 == item })
        }
        else {
            item.locations = dependencies.selectedLocations
            selectedFriends.append(item)
        }
        
        var snapShot = SnapShot()
        
        snapShot.appendSections([.MyFriends])
        
        let items = fetchResultController
            .fetchedObjects
            .or([])
            .compactMap { item -> SelectPersonModel? in
                guard var model: SelectPersonModel = item.toObject() else { return nil }
                model.isSelected = selectedFriends.contains(model) ? true : false
                return model
            }
            .map { DataSourceItem.friend(model: $0) }
        
        snapShot.appendItems(items)
        
        self.$applySnapShot.execute(snapShot, false)
    }
    
    @objc func didTapSave() {
        do {
            try dependencies.personStore.update(selectedFriends)
            coordinatorDelegate?.didsave()
        } catch  {
            coordinatorDelegate?.presentAlert(title: .localize(.error).uppercased(),
                                              message: .localize(.error_on_saving_location),
                                              actionBtnTitle: .localize(.ok).uppercased())
        }
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension SelectableFriendListViewModel: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
        
        var snapShot = SnapShot()
        
        snapShot.appendSections([.MyFriends])
        
        let items = fetchResultController
            .fetchedObjects
            .or([])
            .compactMap { item -> SelectPersonModel? in
                guard var model: SelectPersonModel = item.toObject() else { return nil }
                model.isSelected = selectedFriends.contains(model) ? true : false
                return model
            }
            .map { DataSourceItem.friend(model: $0) }
        
        snapShot.appendItems(items)
        
        self.$applySnapShot.execute(snapShot, true)
    }
}

// MARK: - DiffableDataSource

extension SelectableFriendListViewModel {
    
    enum DataSourceSection: String, Hashable, CaseIterable {
        case MyFriends
    }
    
    enum DataSourceItem: Hashable {
        case friend(model: SelectPersonModel)
    }
}

// MARK: - DI

protocol SelectableFriendListViewModelDependencyProvider {
    var personStore: Store<Person> { get }
    var selectedLocations: [SelectableFriendListLocationModel] { get }
}


