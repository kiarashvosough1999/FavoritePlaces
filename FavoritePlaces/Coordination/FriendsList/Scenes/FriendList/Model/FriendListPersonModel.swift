//
//  FriendListPersonModel.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import Foundation

struct FriendListPersonModel: NSMangedObjectConvertible {
    var identifier: String = UUID().uuidString
    var name: String
    var familyName: String
}
