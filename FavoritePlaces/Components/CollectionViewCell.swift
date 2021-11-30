//
//  CollectionViewCell.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/4/1400 AP.
//

import UIKit

class CollectionViewCell<T>: UICollectionViewCell, ViewProtocol {

    /// item is fed in automatically from ListHeaderController
    var item: T? {
        didSet{
            guard let item = item else { return }
            itemDidSet(model: item)
        }
    }
    
    /// parentController is set to the ListHeaderController that is rendering this cell.  This is useful for scenarios where a cell contains a UIButton and you want to use addTarget(...) to trigger an action in the controller.
    weak var parentController: UIViewController?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        configureView()
        addViews()
        constraintViews()
        subscribeClicks()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configureView() {}
    
    func addViews() {}
    
    func constraintViews() {}
    
    func subscribeClicks() {}
    
    func itemDidSet(model: T) {}
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
