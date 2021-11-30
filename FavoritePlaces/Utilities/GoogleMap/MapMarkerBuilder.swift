//
//  MapMarkerBuilder.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/4/1400 AP.
//

import Foundation
import GoogleMaps

final class MapMarkerBuilder {
    
    @discardableResult
    func createMarker(_ coordinate: CLLocationCoordinate2D) -> GMSMarker {
        
        let animationMarker = MarkerAnimationView(frame: CGRect(x: 0, y: 0, width: 58, height: 58))
        return marker(coordinate, animationMarker)
    }
    
    @discardableResult
    fileprivate func marker(_ coordinate: CLLocationCoordinate2D, _ iconView: UIView? = nil) -> GMSMarker {
        let marker = GMSMarker()
        
        marker.iconView = iconView
        marker.appearAnimation = .none
        marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        marker.opacity = 1
        
        marker.position = coordinate
        
        return marker
    }
}
