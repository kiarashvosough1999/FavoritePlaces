//
//  DiffableDataSourceProvider.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/4/1400 AP.
//

import UIKit

protocol DiffableDataSourceProvider {
    
    associatedtype DataSourceSection: Hashable
    associatedtype DataSourceItem: Hashable
    
    typealias SnapShot = NSDiffableDataSourceSnapshot<DataSourceSection, DataSourceItem>
    
    typealias SnapshotTaker = () -> SnapShot?

    typealias SnapshotApplier = (SnapShot, Bool) -> Void
    
    var applySnapShot: SnapshotApplier? { get set }
    
    var takeSnapShot: SnapshotTaker? { get set }
    
    func setupInitialdataSource()
}

extension DiffableDataSourceProvider where DataSourceSection: CaseIterable {
    
    func onThemeChanged() {
        guard var snapshot = takeSnapShot?() else { return }
        snapshot.reloadAllSections()
        applySnapShot?(snapshot, false)
    }
}
