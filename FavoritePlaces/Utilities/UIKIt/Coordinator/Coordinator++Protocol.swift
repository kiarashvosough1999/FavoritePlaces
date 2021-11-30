//
//  Coordinator++Protocol.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/4/1400 AP.
//

import Foundation
import UIKit
import FittedSheets

protocol Coordinator: AnyObject {
    var isCompleted: (() -> ())? { get set }
    var childCoordinators: [Coordinator] { get set }
    var navigationController: CustomNavigationController? { get set }
    func start()
}

extension Coordinator {
    
    func free(_ child: Coordinator?) {
        childCoordinators.removeAll { $0 === child }
    }
    
    func store(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func modalPresentationViewController(newController: UIViewController, sizes: [SheetSize], willDismiss: GeneralTypeAlias.Completion? = nil, completion: GeneralTypeAlias.Completion? = nil) -> SheetViewController? {
        navigationController?.modalPresentationVC(newController: newController, sizes: sizes, willDismiss: willDismiss, completion: completion)
    }
    
    func showAlert(title: String,
                   message: String = "",
                   actionBtnTitle: String = .localize(.ok).uppercased()) {
        let ac = UIAlertController(title: title,
                                   message: message,
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: actionBtnTitle, style: .default, handler: nil))
        navigationController?.present(ac, animated: true, completion: nil)
    }
}

protocol AlertableCoordination: AnyObject {
    func presentAlert(title: String,
                   message: String,
                   actionBtnTitle: String)
}

protocol FavoritePlacesCoordination: AnyObject {
    func didTapAddLocation()
}

class BaseCoordinator : NSObject, Coordinator {
    var navigationController: CustomNavigationController?
    var childCoordinators : [Coordinator] = []
    @MainQueue var isCompleted: (() -> ())?

    init(navigationController: CustomNavigationController? = nil) {
        self.navigationController = navigationController
        super.init()
    }
    
    func start() {
        fatalError("Children should implement `start`.")
    }
}
