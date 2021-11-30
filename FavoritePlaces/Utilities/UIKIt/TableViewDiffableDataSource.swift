//
//  TableViewDiffableDataSource.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import UIKit

final class TableViewDiffableDataSource<SectionIdentifierType,ItemIdentifierType>: UITableViewDiffableDataSource<SectionIdentifierType, ItemIdentifierType> where SectionIdentifierType: Hashable, ItemIdentifierType: Hashable {
    
    typealias HeaderProvider = (UITableView, Int, SectionIdentifierType) -> String?
    
    typealias OnNumberOfItemsInSections = (Int) -> Void
    
    var headerProvider:HeaderProvider?
    
    var onNumberOfItemsInSections:OnNumberOfItemsInSections?
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let snp = snapshot()
        return headerProvider?(tableView,section, snp.sectionIdentifiers[section])
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let snp = snapshot()
        let items = snp.numberOfItems(inSection: snp.sectionIdentifiers[section])
        onNumberOfItemsInSections?(items)
        return items
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
}
