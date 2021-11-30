//
//  FavoritePlacesViewController.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import UIKit
import GoogleMaps

final class FavoritePlacesViewController: UIViewController, ViewProtocol, MVVMView {
    
    typealias DataSource = UICollectionViewDiffableDataSource<FavoritePlacesViewModel.DataSourceSection, FavoritePlacesViewModel.DataSourceItem>
    
    var viewModel: FavoritePlacesViewModel!
    
    fileprivate let viewMaker = ViewMaker()
    
    // MARK: - Views
    
    fileprivate lazy var markers: [GMSMarker] = []
    
    fileprivate lazy var mapView = viewMaker
        .GMView
        .with(style: AppStyle.GMSMap().favoritePlacesMap())
    
    fileprivate lazy var friendsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.delegate = self
        collectionView.registerCell(FriendSelectableCollectionViewCell.self)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    fileprivate lazy var dataSource = DataSourceFatory
        .CollectionView()
        .collections(collectionView: friendsCollectionView)
    
    // MARK: - LifeCycle
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeMarkersOnDisapear()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addMarkeronAppear()
    }
    
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
        
        viewModel.$animateToPosition.byWrapping(self) { strongSelf, position in
            strongSelf.mapView.animate(to: position)
        }
        
        viewModel.$clearMap.byWrapping(self) { strongSelf in
            strongSelf.mapView.clear()
        }
        
        viewModel.$annotate.byWrapping(self) { strongSelf, marker in
            marker.map = self.mapView
            strongSelf.markers.append(marker)
        }
    }
    
    func configureView() {
        
        let mapStyler = GoogleMapStyleBuilder(mapView: mapView)
        mapStyler.applyMapStyle(resource: "MapStyle")
        
        view.backgroundColor = .white
        
        let navAddItem = UIBarButtonItem(barButtonSystemItem: .add, target: viewModel, action: #selector(viewModel.userDidTapedAdd))
        navigationItem.rightBarButtonItem = navAddItem
    }
    
    func constraintViews() {
        addViews(mapView, friendsCollectionView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 3.5/5),
            
            friendsCollectionView.topAnchor.constraint(equalTo: mapView.bottomAnchor),
            friendsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            friendsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            friendsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    fileprivate func removeMarkersOnDisapear() {
        mapView.clear()
        markers.forEach { $0.pulsateViewControl?.stopPulsate() }
    }
    
    fileprivate func addMarkeronAppear() {
        if isViewLoaded {
            markers.forEach { marker in
                marker.map = mapView
                marker.pulsateViewControl?.pulsate()
            }
        }
    }
}

// MARK: - UICollectionViewDelegate

extension FavoritePlacesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didtapFriend(at: indexPath)
    }
}
