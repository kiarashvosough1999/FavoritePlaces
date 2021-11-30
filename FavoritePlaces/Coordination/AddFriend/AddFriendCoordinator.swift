//
//  AddFriendCoordinator.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import Foundation
import UIKit

final class AddFriendViewCoordinator: BaseCoordinator {
    
    fileprivate var presentedBottomSheet: UIViewController?
    
    fileprivate let dependencies: AddFriendViewCoordinatorDependencyProvider
    
    // MARK: - LifeCycle
    
    init(navigationController: CustomNavigationController? = nil,
         dependencies: AddFriendViewCoordinatorDependencyProvider) {
        self.dependencies = dependencies
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        
        if dependencies.isOnLocationPicking {
            startSelectionList()
        } else {
            startAddController()
        }
    }
    
    fileprivate func startAddController() {
        let dependencies = AddFriendViewModelDependencies(contex: dependencies.contex, friendModel: dependencies.friendModel)
        
        let viewModel = AddFriendViewModel(dependencies: dependencies)
        
        viewModel.coordinatorDelegate = self
        
        let viewController = AddFriendViewController(viewModel: viewModel)
        presentedBottomSheet = modalPresentationViewController(newController: viewController,
                                                               sizes: [.percent(0.3), .fullscreen])
    }
    
    fileprivate func startSelectionList() {
        guard let locations = dependencies.locationModels else { return }
        let dependencies = SelectableFriendListViewModelDependencies(personStore: Store<Person>(context: dependencies.contex.mainContext), selectedLocations: locations.map { SelectableFriendListLocationModel(lat: $0.lat, lng: $0.lng) })
        
        let viewModel = SelectableFriendListViewModel(dependencies: dependencies)
        viewModel.coordinatorDelegate = self
        
        let viewController = SelectableFriendListViewController(viewModel: viewModel)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - AddFriendViewModelCoordination

extension AddFriendViewCoordinator: AddFriendViewModelCoordination {
    
    func didCompleteSaving() {
        presentedBottomSheet?.dismiss(animated: true, completion: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.$isCompleted.execute()
        })
        
    }
    
    func dataIsMissed(message: String) {
        showAlert(title: .localize(.data_is_missing).uppercased(),
                  message: message)
    }
}

// MARK: - SelectableFriendListCoordination

extension AddFriendViewCoordinator: SelectableFriendListCoordination {
    
    func presentAlert(title: String, message: String, actionBtnTitle: String) {
        showAlert(title: title, message: message, actionBtnTitle: actionBtnTitle)
    }
    
    func didsave() {
        navigationController?.popToRootViewController(animated: true)
        $isCompleted.execute()
    }
    
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
}

// MARK: - DI

protocol AddFriendViewCoordinatorDependencyProvider: DataBaseContextDependencyProvider {
    var friendModel: AddFriendPersonModel? { get }
    var locationModels: [LocationHolder]? { get }
    var isOnLocationPicking: Bool { get }
}

// MARK: - Coordination Delegate

protocol SelectableFriendListCoordination: AlertableCoordination {
    func shouldAddFriend()
    func didsave()
}

protocol AddFriendViewModelCoordination: AnyObject {
    func dataIsMissed(message: String)
    func didCompleteSaving()
}
