//
//  FavoritePlacesViewModel.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import CoreData
import UIKit
import GoogleMaps

final class FavoritePlacesViewModel: MVVMViewModel, DiffableDataSourceProvider {
    
    weak var coordinatorDelegate: FavoritePlacesCoordination?
    
    // MARK: - Closure Binding
    
    var takeSnapShot: SnapshotTaker?
    
    @MainQueue1 var annotate: GeneralTypeAlias.DataCompletion<GMSMarker>?
    
    @MainQueue var clearMap: GeneralTypeAlias.ViewModelBasicSignal?
    
    @MainQueue2 var applySnapShot: SnapshotApplier?
    
    @MainQueue1 var animateToPosition: GeneralTypeAlias.DataCompletion<GMSCameraPosition>?
    
    // MARK: - LifeCycle
    
    fileprivate let dependencies: FavoritePlacesViewModelDependencyProvider
    
    init(dependencies: FavoritePlacesViewModelDependencyProvider) {
        self.dependencies = dependencies
    }
    
    func setupInitialdataSource() {
        let repo = dependencies.repository
        
        repo.onContentChangedSnapshot = { [weak self, weak repo] snapshot in
            guard let strongSelf = self, let repo = repo else { return }
            
            var snapShot = SnapShot()
            
            snapShot.appendSections([.MyFriends])
            
            
            let items = repo
                .fetchResults()
                .or([])
                .compactMap { $0.toObject() }
                .compactMap { DataSourceItem.friend(model: $0) }
            
            snapShot.appendItems(items)
            
            strongSelf.$applySnapShot.execute(snapShot, true)
        }
        
        try? repo.performFetchWithFRC()
    }
    
    // will be invoked by collectionViewDelegate
    func didtapFriend(at indexPath: IndexPath) {

        let repo = dependencies.repository
        
        // retrieve locations
        let locations: [Location]? = repo
            .objectProperty(at: indexPath, with: \.locations)?
            .getAllObject()

        // convert to usecase model
        let models: [LocationModel] = locations
            .or([])
            .compactMap { $0.toObject() }
        
        // set camera position on the first location
        // I might had to calculate an area which contains all the location,
        // but for now this is sufficent
        if let first = models.first {
            $animateToPosition
                .execute(GMSCameraPosition(latitude: first.lat,
                                           longitude: first.lng,
                                           zoom: 3))
        }
        setPlacesOnMap(with: models)
    }
    
    fileprivate func setPlacesOnMap(with locations: [LocationModel]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            // remove previouse annot
            self.$clearMap.execute()
            
            // annotate map
            let markerBuilder = MapMarkerBuilder()
            locations.forEach {
                self.$annotate.execute(markerBuilder.createMarker($0.coordinate()))
            }
        }
    }
    
    @objc func userDidTapedAdd() {
        coordinatorDelegate?.didTapAddLocation()
    }
}

// MARK: - DataSource

extension FavoritePlacesViewModel {
    
    enum DataSourceSection: Hashable, CaseIterable {
        case MyFriends
    }
    
    enum DataSourceItem: Hashable {
        case friend(model: FavoritePlacesPersonModel)
    }
}

// MARK: - DI

protocol FavoritePlacesViewModelDependencyProvider {
    var repository: FavoritePlacesRepository { get }
}
