//
//  Person+CoreDataClass.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//
//

import Foundation
import CoreData

@objc(Person)
public class Person: NSManagedObject, ObjectConvertible {
    
    func from<T>(object: T) -> Bool where T : NSMangedObjectConvertible {
        if let object = object as? PersonModel {
            self.name = object.name
            self.uuid = object.identifier
            self.familyName = object.familyName
            self.dateAdded = Date()
            return true
        }
        else if let object = object as? FriendListPersonModel {
            self.name = object.name
            self.uuid = object.identifier
            self.familyName = object.familyName
            self.dateAdded = Date()
            return true
        }
        else if let object = object as? AddFriendPersonModel {
            self.name = object.name
            self.uuid = objectID.uriRepresentation().absoluteString
            self.familyName = object.familyName
            self.dateAdded = Date()
            return true
        }
        else if let object = object as? SelectPersonModel,
                let managedObjectContext = managedObjectContext,
                let locations = try? Location.create(from: object.locations, context: managedObjectContext) {
            self.name = object.name
            self.uuid = objectID.uriRepresentation().absoluteString
            self.familyName = object.familyName
            self.dateAdded = Date()
            
            do {
                try setRelationship(dict: ["locations": locations])
            } catch {
                return false
            }
            
            return true
        }
        return false
    }
    
    func toObject<T>() -> T? where T : NSMangedObjectConvertible {
        if T.self == PersonModel.self {
            return PersonModel(identifier: objectID.uriRepresentation().absoluteString ,
                               name: name.or(""),
                               familyName: familyName.or("")) as? T
        }else if T.self == AddFriendPersonModel.self {
            return AddFriendPersonModel(identifier: objectID.uriRepresentation().absoluteString,
                                        name: name.or(""),
                                        familyName: familyName.or("")) as? T
        }
        else if T.self == SelectPersonModel.self {
            return SelectPersonModel(identifier: objectID.uriRepresentation().absoluteString,
                                     name: name.or(""),
                                     familyName: familyName.or("")) as? T
        }
        else if T.self == FriendListPersonModel.self {
            return FriendListPersonModel(identifier: objectID.uriRepresentation().absoluteString,
                                         name: name.or(""),
                                         familyName: familyName.or("")) as? T
        }
        else if T.self == FavoritePlacesPersonModel.self {
            let manjedObjectLocation: [Location]? = locations?.getAllObject()
            
            return FavoritePlacesPersonModel(identifier: objectID.uriRepresentation().absoluteString,
                                             name: name.or(""),
                                             familyName: familyName.or(""),
                                             locations: manjedObjectLocation.or([]).compactMap { $0.toObject() }) as? T
        }
        return nil
    }
}

struct PersonModel: NSMangedObjectConvertible {
    var identifier: String = UUID().uuidString
    var name: String
    var familyName: String
}
