//
//  LocationModel.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import Foundation
import CoreLocation

struct LocationModel: NSMangedObjectConvertible, LocationHolder {

    var identifier: String = UUID().uuidString
    var lat: Double
    var lng: Double
    
    init(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
    }
    
    init(identifier: String = UUID().uuidString, lat: Double, lng: Double) {
        self.identifier = identifier
        self.lat = lat
        self.lng = lng
    }
    
}

protocol LocationHolder {
    var lat: Double { get }
    var lng: Double { get }
    init(lat: Double,
         lng: Double)
}

extension LocationHolder {
    func coordinate() -> CLLocationCoordinate2D {
        .init(latitude: lat, longitude: lng)
    }
    
    func location() -> CLLocation {
        .init(latitude: lat, longitude: lng)
    }
    
    static func from(cllocationCoordinate2D: CLLocationCoordinate2D) -> Self {
        Self(lat: cllocationCoordinate2D.latitude, lng: cllocationCoordinate2D.longitude)
    }
}
