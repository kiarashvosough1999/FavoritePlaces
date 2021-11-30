//
//  GoogleMapStyleBuilder.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/4/1400 AP.
//

import Foundation
import GoogleMaps

class GoogleMapStyleBuilder {
    
    private var mapView: GMSMapView!
    
    init(mapView: GMSMapView) {
        self.mapView = mapView
    }
    
    func applyMapStyle(resource: String = "MapStyle") {
        // map view style
        do {
            if let styleURL = Bundle.main.url(forResource: "MapStyle", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
    }
    
}
