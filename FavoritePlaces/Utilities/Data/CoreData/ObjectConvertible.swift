//
//  ObjectConvertible.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/4/1400 AP.
//

import Foundation
import CoreData

/// A `NSManagedObject` that wants to be converted from an `NSMangedObjectConvertible` object should implement the `ManagedObjectConvertible` protocol.
protocol ObjectConvertible {
    
    /// A String representing a URI that provides an archiveable reference to the object in Core Data.
    var identifier: String? { get }
    
    /// Insert an object in Core Data.
    ///
    /// - Parameters:
    ///   - object: The object to insert.
    ///   - context: The managed object context.
    @discardableResult
    static func insert<T>(_ object: T, with context: NSManagedObjectContext) throws -> Self where T: NSMangedObjectConvertible
    
    /// Update an object in Core Data.
    ///
    /// - Parameters:
    ///   - object: The object to update.
    ///   - context: The managed object context.
    static func update<T>(_ object: T, with context: NSManagedObjectContext) throws where T: NSMangedObjectConvertible
    
    /// Delete an object from Core Data.
    ///
    /// - Parameters:
    ///   - object: The object to delete.
    ///   - context: The managed object context.
    static func delete<T>(_ object: T, with context: NSManagedObjectContext) throws where T: NSMangedObjectConvertible
    
    static func deleteAll(with context: NSManagedObjectContext) throws
    
    static func deleteAll<T>(_ objects: [T] ,with context: NSManagedObjectContext) throws where T: NSMangedObjectConvertible
    
    static func deleteAll(_ objects: [Self] ,with context: NSManagedObjectContext) throws
    
    static func delete(_ object: Self ,with context: NSManagedObjectContext) throws
    
    /// Fetch all objects from Core Data.
    ///
    /// - Parameter context: The managed object context.
    /// - Returns: A list of objects.
    static func fetchAll<T>(from context: NSManagedObjectContext) throws -> [T] where T: NSMangedObjectConvertible
    
    /// Set the managed object's parameters with an object's parameters.
    ///
    /// - Parameter object: An object.
    func from<T>(object: T) -> Bool where T: NSMangedObjectConvertible
    
    /// Create an object, populated with the managed object's properties.
    ///
    /// - Returns: An object.
    func toObject<T>() -> T? where T: NSMangedObjectConvertible
    
    func setRelationship<T>(dict: [String : T]) throws where T: NSManagedObject
    
    func setRelationship<T>(dict: [String : [T]]) throws where T: NSManagedObject
    
    static func createFetchRequest() -> NSFetchRequest<NSFetchRequestResult>
}

extension ObjectConvertible where Self: NSManagedObject {
    
    var identifier: String? {
        return objectID.uriRepresentation().absoluteString
    }
    
    @discardableResult
    static func insert<T>(_ object: T, with context: NSManagedObjectContext) throws -> Self where T: NSMangedObjectConvertible {
        var _error: FPError = .noError
        var managedObject: Self!
        context.performAndWait {
            
            managedObject = Self(context: context)
            if managedObject.from(object: object).not {
                _error = .dbError(reason: .CannotCreate)
                return
            }
            
            do {
                try context.save()
            } catch {
                _error = .dbError(reason: .CannotSave)
            }
        }
        if _error.isErrorOccured { throw _error }
        return managedObject
    }
    
    static func update<T>(_ object: T, with context: NSManagedObjectContext) throws where T: NSMangedObjectConvertible  {
        var _error: FPError = .noError
        context.performAndWait {
            do {
                guard let managedObject = try get(object: object, with: context) else {
                    _error = .dbError(reason: .CannotFetch)
                    return
                }
                
                if managedObject.from(object: object).not {
                    _error = .dbError(reason: .CannotCreate)
                    return
                }
                try context.save()
            } catch {
                _error = error.asFPError(or: .dbError(reason: .CannotSave))
            }
        }
        if _error.isErrorOccured { throw _error }
    }
    
    static func delete<T>(_ object: T, with context: NSManagedObjectContext) throws where T: NSMangedObjectConvertible {
        var _error: FPError = .noError
        context.performAndWait {
            do {
                guard let managedObject = try get(object: object, with: context) else {
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
    
    static func deleteAll(with context: NSManagedObjectContext) throws {
        var _error: FPError = .noError
        context.performAndWait {
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: createFetchRequest())
            
            do {
                deleteRequest.resultType = .resultTypeObjectIDs
                
                let batchDelete = try context.execute(deleteRequest) as? NSBatchDeleteResult

                guard let deleteResult = batchDelete?.result as? [NSManagedObjectID] else { return }

                let deletedObjects: [AnyHashable: Any] = [NSDeletedObjectsKey: deleteResult]

                NSManagedObjectContext.mergeChanges(
                    fromRemoteContextSave: deletedObjects,
                    into: [context]
                )
            } catch {
                _error = error.asFPError(or: .dbError(reason: .CannotDelete))
            }
        }
        if _error.isErrorOccured { throw _error }
    }
    
    static func deleteAll<T>(_ objects: [T] ,with context: NSManagedObjectContext) throws where T: NSMangedObjectConvertible {
        var _error: FPError = .noError
        context.performAndWait {

            do {
                let managedObjects = try objects.compactMap({ try get(object: $0, with: context) })
                managedObjects.forEach { context.delete($0) }
                try context.save()
            } catch {
                _error = error.asFPError(or: .dbError(reason: .CannotDelete))
            }
        }
        if _error.isErrorOccured { throw _error }
    }
    
    static func deleteAll(_ objects: [Self] ,with context: NSManagedObjectContext) throws {
        var _error: FPError = .noError
        context.performAndWait {

            do {
                objects.forEach { context.delete($0) }
                try context.save()
            } catch {
                _error = error.asFPError(or: .dbError(reason: .CannotDelete))
            }
        }
        if _error.isErrorOccured { throw _error }
    }
    
    static func delete(_ object: Self ,with context: NSManagedObjectContext) throws {
        var _error: FPError = .noError
        context.performAndWait {

            do {
                context.delete(object)
                try context.save()
            } catch {
                _error = error.asFPError(or: .dbError(reason: .CannotDelete))
            }
        }
        if _error.isErrorOccured { throw _error }
    }
    
    static func fetchAll<T>(from context: NSManagedObjectContext) throws -> [T] where T: NSMangedObjectConvertible {
        var items: [T] = []
        var _error: FPError = .noError
        context.performAndWait {
            let request = NSFetchRequest<Self>(entityName: String(describing: self))
            request.returnsObjectsAsFaults = false
            
            do{
                let managedObjects = try context.fetch(request)
                items = managedObjects.compactMap { $0.toObject() }
            } catch {
                _error = .dbError(reason: .CannotFetch)
            }
        }
        if _error.isErrorOccured { throw _error }
        return items
    }
    
    func setRelationship<T>(dict: [String : T]) throws where T: NSManagedObject {
        for (key, newValue) in dict {
            if let newSet = value(forKey: key) as? NSSet { // Releationship is {...} to Many
                setValue(newSet.adding(newValue), forKeyPath: key)
                
            }else { // Releation is {...} to one
                setValue(newValue, forKeyPath: key)
            }
        }
    }
    
    func setRelationship<T>(dict: [String : [T]]) throws where T: NSManagedObject {
        for (key, newValue) in dict {
            if let newSet = value(forKey: key) as? NSSet { // Releationship is {...} to Many
                setValue(newSet.addingObjects(from: newValue), forKeyPath: key)
                
            }else { // imposible to be one to {...} relationship
                throw FPError.dbError(reason: .CannotSetRelationShip)
            }
        }
    }
    
    static func get<T>(object: T, with context: NSManagedObjectContext) throws -> Self? where T: NSMangedObjectConvertible {
        guard
            let uri = URL(string: object.identifier),
            let objectID = context.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: uri) else
            {
                return nil
            }
        
        do {
            return try context.existingObject(with: objectID) as? Self
        } catch {
            throw FPError.dbError(reason: .CannotFindObject)
        }
    }
    
     static func createFetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        return NSFetchRequest(entityName: String(describing: self))
    }
    
    static func from<T>(object: T, context: NSManagedObjectContext) throws -> Self where T: NSMangedObjectConvertible {
        let model = Self(context: context)
        if model.from(object: object).not {
            throw FPError.dbError(reason: .CannotCreate)
        }
        return model
    }
    
    static func create<T>(from object: T, context: NSManagedObjectContext) throws -> Self where T: NSMangedObjectConvertible {
        let managedObject = Self(context: context)
        if managedObject.from(object: object).not {
            throw FPError.dbError(reason: .CannotCreate)
        }
        return managedObject
    }
    
    static func create<T>(from objects: [T], context: NSManagedObjectContext) throws -> [Self] where T: NSMangedObjectConvertible {
        return try objects.map { object in
            let managedObject = Self(context: context)
            if managedObject.from(object: object).not {
                throw FPError.dbError(reason: .CannotCreate)
            }
            return managedObject
        }
    }
}
