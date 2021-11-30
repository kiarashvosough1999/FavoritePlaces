//
//  CompositeTableViewCell.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import UIKit

class CompositeTableViewCell<T, V>: UITableViewCell, ViewProtocol {
    
    /// item is fed in automatically from ListHeaderController
    var item: T? {
        didSet {
            guard let item = item else { return }
            itemDidSet(model: item)
        }
    }
    
    var viewModel: V? {
        didSet {
            guard let viewModel = viewModel else { return }
            ViewModelDidSet(model: viewModel)
        }
    }
    
    /// parentController is set to the ListHeaderController that is rendering this cell.  This is useful for scenarios where a cell contains a UIButton and you want to use addTarget(...) to trigger an action in the controller.
    weak var parentController: UIViewController?
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        configureView()
        constraintViews()
        addTargets()
        
    }
    
    func configureView() {}
    
    func constraintViews() {}
    
    func addTargets() {}
    
    func itemDidSet(model: T) {}
    
    func ViewModelDidSet(model: V) {}
}
