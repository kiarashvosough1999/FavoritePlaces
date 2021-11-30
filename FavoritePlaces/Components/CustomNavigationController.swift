//
//  CustomNavigationController.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/4/1400 AP.
//

import UIKit
import FittedSheets

final class CustomNavigationController: UINavigationController {
    
    func modalPresentationVC(newController: UIViewController, sizes: [SheetSize], willDismiss: GeneralTypeAlias.Completion? = nil, completion: GeneralTypeAlias.Completion? = nil) -> SheetViewController? {
        
        guard let presentationViewController = self.visibleViewController else { return nil }
        
        let options = SheetOptions(
            shouldExtendBackground: true,
            shrinkPresentingViewController: false
        )
        
        let sheetController = SheetViewController(controller: newController, sizes: sizes, options: options)
        sheetController.gripColor = .gray
        sheetController.gripSize = CGSize(width: 60.0, height: 5.0)
        sheetController.autoAdjustToKeyboard = true
        sheetController.allowPullingPastMaxHeight = false
        sheetController.cornerRadius = 30.0
        sheetController.overlayColor = .clear

        sheetController.dismissOnPull = true
        sheetController.dismissOnOverlayTap = true
        
        sheetController.didDismiss = { _ in
            willDismiss?()
        }
        presentationViewController.present(sheetController, animated: true, completion: {
            completion?()
        })
        return sheetController
    }
}
