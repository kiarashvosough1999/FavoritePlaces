//
//  AppStyle++MARK.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import Foundation

extension AppStyle {
    
    struct MARK {
        
        func selcteFriendMark() -> UIViewStyle<MarkView> {
            UIViewStyle<MarkView>.init { view in
                view.checked = false
                view.backgroundColor = .white
                view.isUserInteractionEnabled = true
                view.style = .grayedOut
                view.translatesAutoresizingMaskIntoConstraints = false
            }
        }
        
    }
    
}
