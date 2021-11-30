//
//  FriendsCoordinator.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import Foundation

final class FriendsCoordinator: BaseCoordinator {
    
    fileprivate let dependencies: FriendsCoordinatorDependencyProvider
    
    init(navigationController: CustomNavigationController? = nil, dependencies: FriendsCoordinatorDependencyProvider) {
        self.dependencies = dependencies
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        
        let repository = FriendListRepositoryImpl(store: Store<Person>(context: dependencies.contex.mainContext))
        
        let dependencies = FriendListViewModelDependencies(repository: repository)
        
        let viewModel = FriendListViewModel(dependencies: dependencies)
        viewModel.coordinatorDelegate = self
        
        let viewController = FriendListViewController(viewModel: viewModel)
        
        navigationController?.pushViewController(viewController, animated: false)
    }
}

extension FriendsCoordinator: FriendsCoordinationDelegate {
    
    func shouldAddFriend() {
        let dependencies = AddFriendViewCoordinatorDependencies(contex: dependencies.contex)
        let coordinator = AddFriendViewCoordinator(navigationController: navigationController,
                                                   dependencies: dependencies)
        coordinator.$isCompleted.byWrapping(self, coordinator) { strongSelf, strongCoordinator in
            strongSelf.free(strongCoordinator)
        }
        store(coordinator)
        coordinator.start()
    }
    
    func shouldEditFriend(with model: AddFriendPersonModel) {
        let dependencies = AddFriendViewCoordinatorDependencies(contex: dependencies.contex,
                                                                friendModel: model)
        let coordinator = AddFriendViewCoordinator(navigationController: navigationController,
                                                   dependencies: dependencies)
        coordinator.$isCompleted.byWrapping(self, coordinator) { strongSelf, strongCoordinator in
            strongSelf.free(strongCoordinator)
        }
        store(coordinator)
        coordinator.start()
    }
}

protocol FriendsCoordinatorDependencyProvider: DataBaseContextDependencyProvider { }

protocol FriendsCoordinationDelegate: AnyObject {
    func shouldAddFriend()
    func shouldEditFriend(with model: AddFriendPersonModel)
}
