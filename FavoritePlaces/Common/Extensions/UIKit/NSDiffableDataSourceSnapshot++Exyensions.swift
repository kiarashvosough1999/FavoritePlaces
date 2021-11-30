//
//  NSDiffableDataSourceSnapshot++Exyensions.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/4/1400 AP.
//

import Foundation

import UIKit

extension NSDiffableDataSourceSnapshot {
    
    func item(at indexPath: IndexPath) -> ItemIdentifierType? {
        guard let section = sectionIdentifiers.safeIndex(index: indexPath.section) else { return nil }
        guard let item = itemIdentifiers(inSection: section).safeIndex(index: indexPath.row) else { return nil }
        return item
    }
}

extension NSDiffableDataSourceSnapshot where SectionIdentifierType: CaseIterable {
    
    mutating func reloadAllSections() {
        reloadSections(Array(SectionIdentifierType.allCases))
    }
}
