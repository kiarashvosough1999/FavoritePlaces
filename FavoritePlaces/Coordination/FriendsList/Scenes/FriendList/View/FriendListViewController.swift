//
//  FriendListViewController.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import UIKit

final class FriendListViewController: UIViewController, MVVMView, ViewProtocol {
    
    typealias DataSource = TableViewDiffableDataSource<FriendListViewModel.DataSourceSection, FriendListViewModel.DataSourceItem>
    
    var viewModel: FriendListViewModel!
    
    fileprivate let viewMaker = ViewMaker()
    
    // MARK: - Views
    
    fileprivate lazy var tableView = viewMaker
        .groupedTableView
        .with(style: AppStyle.TableView().friendsTableView())
        .set(\.delegate, to: self)
    
    fileprivate lazy var dataSource = DataSourceFatory
        .TableView()
        .personListTabDataSource(tableView: tableView, viewModel: viewModel)
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        configureView()
        constraintViews()
        addTargets()
        viewModel.setupInitialdataSource()
    }
    
    func setupBindings() {
        viewModel.$applySnapShot.byWrapping(self) { strongSelf, snapshot, animate in
            strongSelf.dataSource.apply(snapshot, animatingDifferences: animate)
        }
        
        viewModel.takeSnapShot = { [weak self] in
            guard let strongSelf = self else { return nil }
            return strongSelf.dataSource.snapshot()
        }
    }
    
    func configureView() {
        title = viewModel.title
        view.backgroundColor = Palette.white
        
        let navAddItem = UIBarButtonItem(barButtonSystemItem: .add, target: viewModel, action: #selector(viewModel.userDidTapedAdd))
        navigationItem.rightBarButtonItem = navAddItem
        
        let navDeleteItem = UIBarButtonItem.init(image: UIImage(systemName: "trash.fill"), style: .plain, target: viewModel, action: #selector(viewModel.userDidTapedDelete))
        navigationItem.leftBarButtonItem = navDeleteItem
    }
    
    func constraintViews() {
        addViews(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        ])
    }
}

extension FriendListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: .localize(.delete).uppercased()) { [weak self] action, view, finished in
            self?.viewModel.didDeleteItem(at: indexPath)
            finished(true)
        }
        
        let editAction = UIContextualAction(style: .normal, title: .localize(.edit).uppercased()) { [weak self] action, view, finished in
            self?.viewModel.didEditItem(at: indexPath)
            finished(true)
        }
        editAction.backgroundColor = Palette.green
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
}
