//
//  Location+CoreDataClass.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//
//

import Foundation
import CoreData

@objc(Location)
public class Location: NSManagedObject, ObjectConvertible {
    
    func from<T>(object: T) -> Bool where T : NSMangedObjectConvertible {
        if let object = object  as? LocationModel {
            self.lat = object.lat
            self.long = object.lng
            self.uuid = objectID.uriRepresentation().absoluteString
            return true
        }
        if let object = object  as? SelectableFriendListLocationModel {
            self.lat = object.lat
            self.long = object.lng
            self.uuid = objectID.uriRepresentation().absoluteString
            return true
        }
        return false
    }
    
    func toObject<T>() -> T? where T : NSMangedObjectConvertible {
        if T.self == LocationModel.self {
            return LocationModel(identifier: objectID.uriRepresentation().absoluteString,
                                 lat: lat,
                                 lng: long) as? T
        }
        return nil
    }
}
