//
//  AppStyle++TextField.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import UIKit

extension AppStyle {
    
    struct TextField {
        
        func nameTextField() -> UIViewStyle<UITextField> {
            UIViewStyle<UITextField>.init { view in
                view.leftViewMode = .always
                view.leftView = UIView(frame: .init(origin: .zero, size: .init(width: 7, height: 1)))
                view.layer.borderColor = Palette.black.cgColor
                view.layer.borderWidth = 1.5
                view.layer.cornerRadius = 10
                view.translatesAutoresizingMaskIntoConstraints = false
                view.backgroundColor = Palette.whiteTwo
                view.placeholder = .localize(.enter_your_name).uppercased()
            }
        }
        
        func lastNameTextField() -> UIViewStyle<UITextField> {
            UIViewStyle<UITextField>.init { view in
                view.leftViewMode = .always
                view.leftView = UIView(frame: .init(origin: .zero, size: .init(width: 7, height: 1)))
                view.layer.borderColor = Palette.black.cgColor
                view.layer.borderWidth = 1.5
                view.layer.cornerRadius = 10
                view.translatesAutoresizingMaskIntoConstraints = false
                view.backgroundColor = Palette.whiteTwo
                view.placeholder = .localize(.enter_your_last_name).uppercased()
            }
        }
    }
}
