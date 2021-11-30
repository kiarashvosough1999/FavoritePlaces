//
//  FindFavoriteCoordination.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import Foundation

final class FindFavoriteCoordinator: BaseCoordinator {
    
    fileprivate let dependencies: FindFavoriteCoordinatorDependencyProvider
    
    init(navigationController: CustomNavigationController? = nil, dependencies: FindFavoriteCoordinatorDependencyProvider) {
        self.dependencies = dependencies
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        
        let repo = FavoritePlacesRepositoryImpl(store: .init(context: dependencies.contex.mainContext))
        
        let dependencies = FavoritePlacesViewModelDependencies(repository: repo)
        
        let viewModel = FavoritePlacesViewModel(dependencies: dependencies)
        
        viewModel.coordinatorDelegate = self
        
        let viewController = FavoritePlacesViewController(viewModel: viewModel)
        
        navigationController?.pushViewController(viewController, animated: false)
    }
}

// MARK: - SelectPlaceCoordination

extension FindFavoriteCoordinator: SelectPlaceCoordination {
    
    func presentAlert(title: String, message: String, actionBtnTitle: String) {
        showAlert(title: title, message: message, actionBtnTitle: actionBtnTitle)
    }
    
    func didSelectedNext(with models: [LocationHolder]) {
        
        let dependencies = AddFriendViewCoordinatorDependencies(locationModels: models,
                                                                contex: dependencies.contex,
                                                                isOnLocationPicking: true)
        
        let coordinator = AddFriendViewCoordinator(navigationController: navigationController,
                                                   dependencies: dependencies)
        
        store(coordinator)
        
        coordinator.$isCompleted.byWrapping(self, coordinator) { strongSelf, coordinator in
            strongSelf.free(coordinator)
        }
        
        coordinator.start()
    }
}

// MARK: FavoritePlacesCoordination

extension FindFavoriteCoordinator: FavoritePlacesCoordination {
    
    func didTapAddLocation() {
        
        let viewModel = SelectPlaceViewModel()
        
        viewModel.coordinatorDelegate = self
        
        let viewController = SelectPlaceViewController(viewModel: viewModel)
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: DI
protocol FindFavoriteCoordinatorDependencyProvider: DataBaseContextDependencyProvider { }

// MARK: - Coordination Delegate

protocol SelectPlaceCoordination: AlertableCoordination {
    func didSelectedNext(with models: [LocationHolder])
}
