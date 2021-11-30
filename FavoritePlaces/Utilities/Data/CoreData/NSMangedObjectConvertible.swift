//
//  NSMangedObjectConvertible.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/4/1400 AP.
//

import Foundation


/// An object that wants to be convertible in a managed object should implement the `ObjectConvertible` protocol.
protocol NSMangedObjectConvertible: Hashable {
    /// An identifier that is used to fetch the corresponding database object.
    var identifier: String { get }
}
