//
//  AppStyle++Button.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import UIKit

extension AppStyle {
    
    struct Button {
        func addFriendSaveButton() -> UIViewStyle<UIButton> {
            UIViewStyle<UIButton>.init { view in
                view.layer.cornerRadius = 10
                view.setTitleColor(Palette.white, for: .normal)
                view.setTitle(.localize(.save).uppercased(), for: .normal)
                view.translatesAutoresizingMaskIntoConstraints = false
                view.backgroundColor = Palette.blue
            }
        }
        
        func addFriendCancelButton() -> UIViewStyle<UIButton> {
            UIViewStyle<UIButton>.init { view in
                view.layer.cornerRadius = 10
                view.setTitleColor(Palette.white, for: .normal)
                view.setTitle(.localize(.cancel).uppercased(), for: .normal)
                view.translatesAutoresizingMaskIntoConstraints = false
                view.backgroundColor = Palette.blue
            }
        }
        
        func selectableFriendListViewControllerSaveButton() -> UIViewStyle<UIButton> {
            UIViewStyle<UIButton>.init { view in
                view.layer.cornerRadius = 10
                view.setTitleColor(Palette.white, for: .normal)
                view.setTitle(.localize(.save).uppercased(), for: .normal)
                view.translatesAutoresizingMaskIntoConstraints = false
                view.backgroundColor = Palette.blue
            }
        }
    }
    
}
