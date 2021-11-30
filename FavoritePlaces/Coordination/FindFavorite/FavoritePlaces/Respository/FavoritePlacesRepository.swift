//
//  FavoritePlacesRepository.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/7/1400 AP.
//

import Foundation
import CoreData
import UIKit

final class FavoritePlacesRepositoryImpl: NSObject, FavoritePlacesRepository {
    
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

extension FavoritePlacesRepositoryImpl: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
        self.onContentChangedSnapshot?(snapshot)
    }
}

protocol FavoritePlacesRepository: FRCBaseRepository {
    func fetchResults() -> [Person]?
    func object(at indexPath: IndexPath) -> Person
    func indexPath(forObject object: Person) -> IndexPath?
    func objectProperty<T>(at indexPath: IndexPath,with propertyKey: KeyPath<Person,T>) -> T
}
