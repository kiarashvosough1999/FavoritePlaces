//
//  AppStyle++GMSMapView.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import GoogleMaps

extension AppStyle {
    
    struct GMSMap {
        
        func favoritePlacesMap() -> UIViewStyle<GMSMapView> {
            UIViewStyle<GMSMapView>.init { view in
                let mapStyler = GoogleMapStyleBuilder(mapView: view)
                mapStyler.applyMapStyle(resource: "MapStyle")
                view.isMyLocationEnabled = true
                view.settings.myLocationButton = true
                view.settings.indoorPicker = false
                view.isBuildingsEnabled = false
                view.isIndoorEnabled = false
                view.translatesAutoresizingMaskIntoConstraints = false
            }
        }
    }
    
}
