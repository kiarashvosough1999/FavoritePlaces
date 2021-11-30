//
//  AddFriendViewCoordinatorDependencies.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import Foundation

struct AddFriendViewCoordinatorDependencies: AddFriendViewCoordinatorDependencyProvider {
    var locationModels: [LocationHolder]? = nil
    var contex: CD
    var friendModel: AddFriendPersonModel? = nil
    var isOnLocationPicking: Bool = false
}
