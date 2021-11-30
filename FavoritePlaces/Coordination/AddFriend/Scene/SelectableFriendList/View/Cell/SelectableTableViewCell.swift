//
//  SelectableTableViewCell.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import UIKit

final class SelectableTableViewCell: TableViewCell<SelectPersonModel> {
    
    // MARK: - Properties
    
    fileprivate let viewMaker = ViewMaker()
    
    // MARK: - Views
    
    fileprivate lazy var markView = viewMaker
        .markView
        .with(style: AppStyle.MARK().selcteFriendMark())
    
    fileprivate lazy var title = viewMaker
        .label
        .with(style: AppStyle.Label().selectableCellText())
    
    // MARK: - Impl
    
    override func itemDidSet(model: SelectPersonModel) {
        title.text = model.name + " " + model.familyName
        markView.checked = model.isSelected
    }
    
    override func constraintViews() {
        contentView.addSubview(markView)
        contentView.addSubview(title)
        
        NSLayoutConstraint.activate([
            
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            markView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            markView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:  -15),
            markView.heightAnchor.constraint(equalTo: contentView.heightAnchor,multiplier: 1/2),
            markView.widthAnchor.constraint(equalTo: markView.heightAnchor)
        ])
    }
}
