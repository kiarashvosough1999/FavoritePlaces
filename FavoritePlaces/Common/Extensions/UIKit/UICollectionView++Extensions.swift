//
//  UICollectionView++Extensions.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/6/1400 AP.
//

import UIKit

extension UICollectionView {
    
    func getCellForItem<T>(at indexPath: IndexPath) -> T? where T:UICollectionViewCell {
        self.cellForItem(at: indexPath) as? T
    }
    
    func cellForItem<T>(at indexPath: IndexPath, with type: T.Type) -> T? where T:UICollectionViewCell {
        self.cellForItem(at: indexPath) as? T
    }
    
    func registerCell(_ cellClass: AnyClass) {
        self.register(cellClass, forCellWithReuseIdentifier: String(describing: cellClass.self))
    }
    
    func registerHeaderSupplementaryView(_ viewClass: AnyClass) {
        self.register(viewClass,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: String(describing: viewClass.self))
    }
    
    func registerFooterSupplementaryView(_ viewClass: AnyClass) {
        self.register(viewClass,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                      withReuseIdentifier: String(describing: viewClass.self))
    }
    
    func dequeueReusableCell<T:UICollectionViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
    }
    
    func dequeueReusableHeaderSupplementaryView<T:UICollectionReusableView>(for indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                withReuseIdentifier: String(describing: T.self),
                                                for: indexPath) as! T
    }
    
    func dequeueReusableFooterSupplementaryView<T:UICollectionReusableView>(for indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                withReuseIdentifier: String(describing: T.self),
                                                for: indexPath) as! T
    }
}
