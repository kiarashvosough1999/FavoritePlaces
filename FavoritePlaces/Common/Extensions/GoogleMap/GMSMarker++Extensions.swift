//
//  GMSMarker++Extensions.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/6/1400 AP.
//

import GoogleMaps

extension GMSMarker {
    
    var pulsateViewControl: PulsateControl? {
        self.iconView as? PulsateControl
    }
}
