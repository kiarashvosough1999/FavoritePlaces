//
//  FavoritePlacesViewController++CollectionViewLayout.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/6/1400 AP.
//

import UIKit

extension FavoritePlacesViewController {
    
    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
            guard let self = self else { fatalError() }
            let isWideView = layoutEnvironment.container.effectiveContentSize.width > 500
            
            let sectionLayoutKind = FavoritePlacesViewModel.DataSourceSection.allCases[sectionIndex]
            
            switch (sectionLayoutKind) {
            case .MyFriends: return self.generateFriendsLayout(isWide: isWideView)
            }
        }
        return layout
    }

    fileprivate func generateFriendsLayout(isWide: Bool) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(10),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(10),
            heightDimension: .fractionalHeight(0.8))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 5, bottom: 2, trailing: 2)
        return section
    }
}
