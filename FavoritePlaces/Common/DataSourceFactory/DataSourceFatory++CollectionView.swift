//
//  DataSourceFatory++CollectionView.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/6/1400 AP.
//

import UIKit

extension DataSourceFatory {
    
    struct CollectionView {
        func collections(collectionView: UICollectionView) -> FavoritePlacesViewController.DataSource {
            let dataSource = FavoritePlacesViewController.DataSource(collectionView: collectionView) { collectionView, indexPath, item in
                print("dskadjkasjdkasjdkjasdksajdkasjdkjaskdjaskdjkasjd")
                let section = FavoritePlacesViewModel.DataSourceSection.allCases[indexPath.section]
                
                switch (section, item) {
                    case (.MyFriends, let .friend(model)):
                        let cell: FriendSelectableCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                        cell.item = model
                        return cell
                }
            }
            return dataSource
        }
    }
    
}
