//
//  SelectableFriendListViewController.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import UIKit

final class SelectableFriendListViewController: UIViewController, MVVMView {
    
    typealias DataSource = TableViewDiffableDataSource<SelectableFriendListViewModel.DataSourceSection, SelectableFriendListViewModel.DataSourceItem>
    
    // MARK: - Properties
    
    var viewModel: SelectableFriendListViewModel!
    
    fileprivate let viewMaker = ViewMaker()
    
    // MARK: - Views
    
    fileprivate lazy var saveButton = viewMaker
        .button
        .with(style: AppStyle.Button().selectableFriendListViewControllerSaveButton())
    
    fileprivate lazy var tableView = viewMaker
        .groupedTableView
        .with(style: AppStyle.TableView().selectFriendsTableView())
        .set(\.delegate, to: self)
    
    fileprivate lazy var dataSource = DataSourceFatory
        .TableView()
        .personSelectListDataSource(tableView: tableView)
    
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
        
        let navAddItem = UIBarButtonItem(barButtonSystemItem: .add,
                                         target: viewModel,
                                         action: #selector(viewModel.userDidTapedAdd))
        navigationItem.rightBarButtonItem = navAddItem
    }
    
    func constraintViews() {
        addViews(tableView, saveButton)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: saveButton.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            saveButton.heightAnchor.constraint(equalToConstant: 45),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -15),
        ])
    }
    
    func addTargets() {
        saveButton.addTarget(viewModel, action: #selector(viewModel.didTapSave), for: .touchUpInside)
    }
}

// MARK: - UITableViewDelegate

extension SelectableFriendListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectedRow(with: indexPath)
    }
}
