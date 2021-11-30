//
//  UITabBarAppearance++Extensions.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import UIKit

extension UITabBarAppearance {
    
    convenience init(backgroundColor: UIColor) {
        self.init()
        self.backgroundColor = backgroundColor
    }
    
    /// On IOS 15 scroll appreance should be configured to avoid mis behavior
    ///
    func makeNoDistinctForScrollAndStandardTabBarAppreance(on tabBar: UITabBar? = nil) {
        if tabBar.isNil {
            UITabBar.appearance().standardAppearance = self
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = self
            }
        }else {
            tabBar?.standardAppearance = self
            if #available(iOS 15.0, *) {
                tabBar?.scrollEdgeAppearance = self
            }
        }

    }
    
}
