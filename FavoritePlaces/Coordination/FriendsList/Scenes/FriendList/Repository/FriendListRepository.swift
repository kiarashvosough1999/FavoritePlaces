//
//  FriendListRepository.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/8/1400 AP.
//

import CoreData
import UIKit

final class FriendListRepositoryImpl: NSObject, FriendListRepository {

    var onContentChangedSnapshot: OnContentChangedSnapshot?
    
    var store: Store<Person>
    
    // MARK: -  LifeCycle
    
    init(store: Store<Person>) {
        self.store = store
        super.init()
    }
    
    func performFetchWithFRC() throws {
        store.relationshipKeyPathsForPrefetching = [#keyPath(Person.locations)]
        
        store.sortDescriptors = [NSSortDescriptor(keyPath: \Person.dateAdded, ascending: false)]
        
        store.fetchedResultsController.delegate = self
        
        try store.fetchedResultsController.performFetch()
    }
    
    func deleteObject(at indexPath: IndexPath) throws {
        let item = object(at: indexPath)
        try store.delete(item)
    }
    
    func deleteAllUser() throws {
        try store.deleteAll()
    }
    
    func fetchResults() -> [Person]? {
        store.fetchedResultsController.fetchedObjects
    }
    
    func object(at indexPath: IndexPath) -> Person {
        store.fetchedResultsController.object(at: indexPath)
    }
    
    func objectProperty<T>(at indexPath: IndexPath,with propertyKey: KeyPath<Person,T>) -> T {
        store.fetchedResultsController.object(at: indexPath)[keyPath: propertyKey]
    }
    
    func indexPath(forObject object: Person) -> IndexPath? {
        store.fetchedResultsController.indexPath(forObject: object)
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension FriendListRepositoryImpl: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
        self.onContentChangedSnapshot?(snapshot)
    }
}


protocol FriendListRepository: FRCBaseRepository {
    func deleteObject(at indexPath: IndexPath) throws
    func deleteAllUser() throws
    func fetchResults() -> [Person]?
    func object(at indexPath: IndexPath) -> Person
    func indexPath(forObject object: Person) -> IndexPath?
    func objectProperty<T>(at indexPath: IndexPath,with propertyKey: KeyPath<Person,T>) -> T
}
