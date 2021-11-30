//
//  NSSet++Extensions.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import Foundation

extension NSSet {
    
    func getAllObject<T>() -> [T]? {
        if self.allObjects.isEmpty { return [] }
        guard let objects = self.allObjects as? [T] else {
            return nil
        }
        return objects
    }
    
    func getFirstObject<T>() -> T? {
        guard let object = self.allObjects.first as? T else {
            return nil
        }
        return object
    }

    func allObjects<T>() -> [T]? {
        return self.allObjects as? [T]
    }
}
