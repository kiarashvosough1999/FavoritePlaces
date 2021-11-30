//
//  CD.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/4/1400 AP.
//

import Foundation
import CoreData

final class CD {
    
    private var container: NSPersistentContainer {
        didSet {
            loadStore()
        }
    }
    
    private func loadStore() {
        container.loadPersistentStores { storeDesription, error in
            guard error == nil else {
                fatalError("Unresolved error \(error!)")
            }
        }
    }
    
    init(with container: NSPersistentContainer = NSPersistentContainer(name: "FavoritePlaces")) {
        self.container = container
        container.persistentStoreDescriptions.first?.shouldInferMappingModelAutomatically = true
        container.persistentStoreDescriptions.first?.shouldMigrateStoreAutomatically = true
        loadStore()
    }
    
    // I did not impelement background context as it may required more time to implement and handle the changes
    // the whole project use main context, although it is not the rigth way
    public lazy var mainContext: NSManagedObjectContext = {
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.undoManager = nil
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        
        return container.viewContext
    }()
}
