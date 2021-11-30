//
//  AppStyle++Label.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import UIKit

extension AppStyle {
    
    struct Label {
        func selectableCellText() -> UIViewStyle<UILabel> {
            UIViewStyle<UILabel>.init { view in
                view.textColor = .black
                view.translatesAutoresizingMaskIntoConstraints = false
            }
        }
        func friendSelectableCollectionViewCellNameText() -> UIViewStyle<UILabel> {
            UIViewStyle<UILabel>.init { view in
//                view.setContentHuggingPriority(.required, for: .horizontal)
                view.textColor = .black
                view.font = .boldSystemFont(ofSize: 17)
                view.translatesAutoresizingMaskIntoConstraints = false
            }
        }
        
    }
    
}
