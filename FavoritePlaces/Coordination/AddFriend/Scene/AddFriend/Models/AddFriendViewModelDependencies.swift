//
//  AddFriendViewModelDependencies.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import Foundation

struct AddFriendViewModelDependencies: AddFriendViewModelDependencyProvider {
    var contex: CD
    var friendModel: AddFriendPersonModel? = nil
}
