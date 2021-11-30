//
//  SelectableFriendListViewModelDependencies.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import Foundation

struct SelectableFriendListViewModelDependencies: SelectableFriendListViewModelDependencyProvider {
    var personStore: Store<Person>
    var selectedLocations: [SelectableFriendListLocationModel]
}
