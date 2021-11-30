//
//  MVVM++Protocols.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/4/1400 AP.
//

import Foundation
import UIKit

protocol MVVM: AnyObject {}

protocol MVVMView: MVVM, ViewProtocol, UIViewController {
    associatedtype T = MVVMViewModel
    
    var viewModel: T! { get set }
    init(viewModel: T)
    func setupBindings()
}

extension MVVMView {
    
    func setupBindings() { }
    
    init(viewModel: T) {
        self.init()
        self.viewModel = viewModel
    }
}

protocol MVVMViewModel: MVVM {
    var title: String { get }
}
extension MVVMViewModel {
    var title: String { "" }
}


protocol ViewProtocol: AnyObject {
    func configureView()
    func addViews(_ views: UIView...)
    func constraintViews()
    func addTargets()
}

extension ViewProtocol {
    
    func addViews(_ views: UIView...) {
        if let view = (self as? UIViewController)?.view {
            views.forEach { (View) in
                view.addSubview(View)
            }
        }
        else if let view = (self as? UICollectionViewCell)?.contentView {
            views.forEach { (View) in
                view.addSubview(View)
            }
        }
        
    }
    func addTargets() {}
}
