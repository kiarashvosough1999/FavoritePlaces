//
//  Bool++Extensions.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import Foundation

extension Bool {
    
    var not: Bool { !self }
    
    var isTrue: Bool { self == true ? true : false }
    
    var isFalse: Bool { self == false ? true : false }
    
    mutating func toggleTrue() { self = true }
    
    mutating func toggleFalse() { self = false }
}
