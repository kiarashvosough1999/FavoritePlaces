//
//  FavoritePlacesPersonModel.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import Foundation

struct FavoritePlacesPersonModel: NSMangedObjectConvertible {
    var identifier: String = UUID().uuidString
    var name: String
    var familyName: String
    var locations: [LocationModel]
}
