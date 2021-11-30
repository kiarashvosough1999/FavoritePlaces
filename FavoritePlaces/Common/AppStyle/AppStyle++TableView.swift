//
//  AppStyle++TableView.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import UIKit

extension AppStyle {
    
    struct TableView {
        
        func friendsTableView() -> UIViewStyle<UITableView> {
            UIViewStyle<UITableView>.init { view in
                view.register(cellWithClass: FriendTableViewCell.self)
                view.isScrollEnabled = true
                view.indicatorStyle = .default
                view.translatesAutoresizingMaskIntoConstraints = false
                view.clipsToBounds = true
                view.backgroundColor = .clear
                view.separatorStyle = .none
            }
        }
        
        func selectFriendsTableView() -> UIViewStyle<UITableView> {
            UIViewStyle<UITableView>.init { view in
                view.register(cellWithClass: SelectableTableViewCell.self)
                view.isScrollEnabled = true
                view.indicatorStyle = .default
                view.translatesAutoresizingMaskIntoConstraints = false
                view.clipsToBounds = true
                view.backgroundColor = .clear
                view.separatorStyle = .none
            }
        }
        
    }
    
}
