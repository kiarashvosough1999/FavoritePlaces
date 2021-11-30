//
//  FriendSelectableCollectionViewCell.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/6/1400 AP.
//

import UIKit

final class FriendSelectableCollectionViewCell: CollectionViewCell<FavoritePlacesPersonModel> {
    
    fileprivate let viewMaker = ViewMaker()
    
    // MARK: - Views
    
    fileprivate lazy var nameLabel = viewMaker
        .label
        .with(style: AppStyle.Label().friendSelectableCollectionViewCellNameText())
    
    
    override func itemDidSet(model: FavoritePlacesPersonModel) {
        nameLabel.text = model.name + " " + model.familyName
    }
    
    override func configureView() {
        contentView.layer.borderWidth = 1.5
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.cornerRadius = 8
    }
    
    override func addViews() {
        contentView.addSubview(nameLabel)
    }
    
    override func constraintViews() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
