//
//  Store.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import Foundation
import CoreData

final class Store<Object> where Object: ObjectConvertible & NSManagedObject {
    
    let context: NSManagedObjectContext
    
    private var fetchRequest: NSFetchRequest<NSFetchRequestResult> = Object.createFetchRequest()
    
    public lazy var fetchedResultsController: NSFetchedResultsController<Object> = {
        fetchRequest.resultType = .managedObjectResultType
        
        let fetchRequestForFRC = fetchRequest as! NSFetchRequest<Object>
        
        let frc = NSFetchedResultsController<Object>(fetchRequest: fetchRequestForFRC, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        return frc
    }()
    
    public var sortDescriptors: [NSSortDescriptor]? {
        set {
            fetchRequest.sortDescriptors = newValue
        }
        get {
            return fetchRequest.sortDescriptors
        }
    }
    
    public var predicate: NSPredicate? {
        set {
            fetchRequest.predicate = newValue
        }
        get {
            return fetchRequest.predicate
        }
    }
    
    public var relationshipKeyPathsForPrefetching: [String]? {
        set {
            fetchRequest.relationshipKeyPathsForPrefetching = newValue
        }
        get {
            return fetchRequest.relationshipKeyPathsForPrefetching
        }
    }

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func fetchAll<T>() throws -> [T] where T: NSMangedObjectConvertible {
        return try Object.fetchAll(from: context)
    }
    
    func insert<T>(object: T) throws where T: NSMangedObjectConvertible {
        try Object.insert(object, with: context)
    }
    
    func insert<T>(object: T) throws -> Object where T: NSMangedObjectConvertible {
        return try Object.insert(object, with: context)
    }
    
    func insert<T>(objects: [T]) throws -> [Object] where T: NSMangedObjectConvertible {
        var temp: [Object] = []
        try objects.forEach { temp.append(try Object.insert($0, with: context)) }
        return temp
    }
    
    func insert<T>(objects: [T]) throws where T: NSMangedObjectConvertible {
        try objects.forEach { try Object.insert($0, with: context) }
    }
    
    func update<T>(_ object: T) throws where T: NSMangedObjectConvertible {
        try Object.update(object, with: context)
    }
    
    func update<T>(_ objects: [T]) throws where T: NSMangedObjectConvertible {
        try objects.forEach { try Object.update($0, with: context) }
    }
    
    func get<T>(object: T) throws -> Object? where T: NSMangedObjectConvertible {
        guard
            let uri = URL(string: object.identifier),
            let objectID = context.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: uri) else
            {
                return nil
            }
        
        do {
            return try context.existingObject(with: objectID) as? Object
        } catch {
            throw FPError.dbError(reason: .CannotFindObject)
        }
    }
    
    func get(object: Object) throws -> Object? {
        guard let objectID = context.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: object.objectID.uriRepresentation()) else {
                return nil
            }
        
        do {
            return try context.existingObject(with: objectID) as? Object
        } catch {
            throw FPError.dbError(reason: .CannotFindObject)
        }
    }
    
    func getAll<T>(objects: [T]) throws -> [Object] where T: NSMangedObjectConvertible {
        do {
            return try objects.compactMap {
                guard
                    let uri = URL(string: $0.identifier),
                    let objectID = context.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: uri) else {  return nil }
                return try context.existingObject(with: objectID) as? Object
            }
        } catch {
            throw FPError.dbError(reason: .CannotFindObject)
        }
    }
    
    func create<T>(from object: T) -> Object where T: NSMangedObjectConvertible {
        let managedObject = Object(context: context)
        managedObject.from(object: object)
        return managedObject
    }
    
    func deleteAll() throws {
        try Object.deleteAll(with: context)
    }
    
    func delete(_ object: Object) throws {
        var _error: FPError = .noError
        context.performAndWait {
            do {
                guard let managedObject = try get(object: object) else {
                    return
                }
                
                context.delete(managedObject)
                try context.save()
            } catch  {
                _error = error.asFPError(or: .dbError(reason: .CannotSave))
            }
        }
        if _error.isErrorOccured { throw _error }
    }
}
