//
//  CompositeCollectionViewCell.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/4/1400 AP.
//

import UIKit

class CompositeCollectionViewCell<T,ViewModel>: UICollectionViewCell, ViewProtocol where ViewModel: MVVMViewModel {
    
    /// item is fed in automatically from ListHeaderController
    var item: T? {
        didSet{
            guard let item = item else { return }
            itemDidSet(model: item)
        }
    }
    
    /// parentController is set to the ListHeaderController that is rendering this cell.  This is useful for scenarios where a cell contains a UIButton and you want to use addTarget(...) to trigger an action in the controller.
    weak var parentController: UIViewController?
    
    weak var viewModel: ViewModel? {
        didSet{
            guard let viewModel = viewModel else { return }
            viewModelDidSet(viewModel: viewModel)
        }
    }
    
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        configureView()
        addViews()
        constraintViews()
        addTargets()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configureView() {}
    
    func addViews() {}
    
    func constraintViews() {}
    
    func addTargets() {}
    
    func itemDidSet(model: T) {}
    
    func viewModelDidSet(viewModel: ViewModel) {}
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
