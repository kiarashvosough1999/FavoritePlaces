//
//  AppCoordinator.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import UIKit
import GoogleMaps

final class AppCoordinator: BaseCoordinator {
    
    let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
        super.init()
    }
    
    override func start() {
        guard let window = window else { return }
        
        GMSServices.provideAPIKey(UserDefaultsConfig.googleAPIToken)
        
        let tabBar = UITabBarController()
        
        let tabBarCoorinator = TabCoordinator(tabController: tabBar)
        tabBarCoorinator.$isCompleted.byWrapping(self) { strongSelf in
            strongSelf.$isCompleted.execute()
        }
        store(tabBarCoorinator)
        tabBarCoorinator.start()
        
        window.rootViewController = tabBar
        window.makeKeyAndVisible()
    }
}

extension AppCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // Read the view controller we’re moving from.
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        // Check whether our view controller array already contains that view controller. If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
    }
}
