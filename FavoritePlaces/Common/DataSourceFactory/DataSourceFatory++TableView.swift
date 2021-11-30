//
//  DataSourceFatory++TableView.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import UIKit

extension DataSourceFatory {
    
    struct TableView {
        
        func personListTabDataSource(tableView: UITableView, viewModel: FriendListViewModel) -> FriendListViewController.DataSource {
            let dataSource = FriendListViewController.DataSource(tableView: tableView, cellProvider: { [weak viewModel] tableView, indexPath, model in
                
                let section = FriendListViewModel.DataSourceSection.allCases[indexPath.section]
                
                switch (section, model) {
                case (.MyFriends, let .friend(model)):
                    let cell = tableView.dequeueReusableCell(withClass: FriendTableViewCell.self, for: indexPath)
                    cell.selectionStyle = .none
                    cell.viewModel = viewModel
                    cell.item = model
                    return cell
                }
                
            })
            
            dataSource.headerProvider = { tableView, section, SectionIdentifierType in
                return SectionIdentifierType.rawValue.uppercased()
            }
            
            dataSource.defaultRowAnimation = .left
            
            return dataSource
        }
        
        func personSelectListDataSource(tableView: UITableView) -> SelectableFriendListViewController.DataSource {
            let dataSource = SelectableFriendListViewController.DataSource(tableView: tableView, cellProvider: { tableView, indexPath, model in
                
                let section = SelectableFriendListViewModel.DataSourceSection.allCases[indexPath.section]
                
                switch (section, model) {
                case (.MyFriends, let .friend(model)):
                    let cell = tableView.dequeueReusableCell(withClass: SelectableTableViewCell.self, for: indexPath)
                    cell.selectionStyle = .none
                    cell.item = model
                    return cell
                }
                
            })
            
            dataSource.headerProvider = { tableView, section, SectionIdentifierType in
                return SectionIdentifierType.rawValue.uppercased()
            }
            
            dataSource.defaultRowAnimation = .left
            
            return dataSource
        }
        
    }
    
}
