//
//  FriendTableViewCell.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import UIKit

final class FriendTableViewCell: CompositeTableViewCell<FriendListPersonModel, FriendListViewModel> {
    
    override func itemDidSet(model: FriendListPersonModel) {
        self.textLabel?.text = model.name + " " + model.familyName
    }
    
}
