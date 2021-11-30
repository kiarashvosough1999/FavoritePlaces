//
//  SelectableFriendListLocationModel.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/6/1400 AP.
//

import Foundation

struct SelectableFriendListLocationModel: LocationHolder, NSMangedObjectConvertible {
    var identifier: String = UUID().uuidString
    var lat: Double
    var lng: Double
    
    init(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
    }
    
}
