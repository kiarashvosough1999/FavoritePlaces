//
//  AppStyle++StackView.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import UIKit

extension AppStyle {
    
    struct StackView {
        func inputFieldStackView() -> UIViewStyle<UIStackView> {
            UIViewStyle<UIStackView>.init { view in
                view.distribution = .fillEqually
                view.spacing = 5
                view.axis = .vertical
                view.translatesAutoresizingMaskIntoConstraints = false
                view.backgroundColor = .clear
            }
        }
        
        func saveButtonStackView() -> UIViewStyle<UIStackView> {
            UIViewStyle<UIStackView>.init { view in
                view.distribution = .fillEqually
                view.spacing = 5
                view.axis = .horizontal
                view.translatesAutoresizingMaskIntoConstraints = false
                view.backgroundColor = .clear
            }
        }
    }
    
}
