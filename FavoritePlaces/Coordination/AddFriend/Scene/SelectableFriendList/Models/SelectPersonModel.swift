//
//  SelectPersonModel.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import Foundation

struct SelectPersonModel: NSMangedObjectConvertible, Equatable {
    var identifier: String = UUID().uuidString
    var name: String
    var familyName: String
    var isSelected: Bool = false
    var locations: [SelectableFriendListLocationModel] = []
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.identifier == rhs.identifier &&
        lhs.name == rhs.name &&
        lhs.familyName == rhs.familyName
    }
}
