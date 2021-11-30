//
//  Array++Extensions.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/4/1400 AP.
//

import Foundation

extension Array {
    func safeIndex(index: Int) -> Array.Element? {
        if count > index && index >= 0 {
            return self[index]
        }
        return nil
    }
}
