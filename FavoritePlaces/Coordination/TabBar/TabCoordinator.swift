//
//  TabCoordinator.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import UIKit

final class TabCoordinator: BaseCoordinator {
    
    fileprivate var tabController: UITabBarController!
    
    fileprivate lazy var context: CD = { CD() }()
    
    // MARK: - LifeCycle
    
    init(tabController: UITabBarController) {
        self.tabController = tabController
    }
    
    override func start() {
        tabController.tabBar.barTintColor = Palette.white
        tabController.tabBar.tintColor = Palette.halfLightBlue
        UITabBarAppearance(backgroundColor: Palette.whiteTwo)
            .makeNoDistinctForScrollAndStandardTabBarAppreance(on: tabController.tabBar)
        tabController.viewControllers = [createFindTab(), createFriendsTab()]
        
    }
    
    fileprivate func createFindTab() -> CustomNavigationController {
        let findNav = CustomNavigationController()
        let findTabItem = UITabBarItem(title: .localize(.find).uppercased(), image: UIImage(systemName: "mappin.square"), tag: 0)
        findNav.tabBarItem = findTabItem
        
        let dependencies = FindFavoriteCoordinatorDependencies(contex: context)
        let findCoordinator = FindFavoriteCoordinator(navigationController: findNav, dependencies: dependencies)
        findCoordinator.$isCompleted.byWrapping(self) { strongSelf in
            strongSelf.$isCompleted.execute()
        }
        self.store(findCoordinator)
        findCoordinator.start()
        return findNav
    }
    
    fileprivate func createFriendsTab() -> CustomNavigationController {
        let FriendsNav = CustomNavigationController()
        let FriendsTabItem = UITabBarItem(title: .localize(.friends).uppercased(), image: UIImage(systemName: "person.3"), tag: 1)
        FriendsNav.tabBarItem = FriendsTabItem
        
        let dependencies = FriendsCoordinatorDependencies(contex: context)
        let FriendsCoordinator = FriendsCoordinator(navigationController: FriendsNav, dependencies: dependencies)
        FriendsCoordinator.$isCompleted.byWrapping(self) { strongSelf in
            strongSelf.$isCompleted.execute()
        }
        self.store(FriendsCoordinator)
        FriendsCoordinator.start()
        return FriendsNav
    }
}
