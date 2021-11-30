//
//  SelectPlaceViewModel.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/6/1400 AP.
//

import CoreLocation
import GoogleMaps

final class SelectPlaceViewModel: MVVMViewModel {
    
    weak var coordinatorDelegate: SelectPlaceCoordination?
    
    fileprivate lazy var selectedLocation: [SelectPlaceLocationHolder] = []
    
    var title: String { .localize(.choose_location).uppercased() }
    
    // MARK: - Closure Binding
    
    @MainQueue1 var annotate: GeneralTypeAlias.DataCompletion<GMSMarker>?
    
    @MainQueue var clearMap: GeneralTypeAlias.ViewModelBasicSignal?
    
    @MainQueue1 var animateToPosition: GeneralTypeAlias.DataCompletion<GMSCameraPosition>?
    
    // MARK: -
    
    func didTapAt(coordinate: CLLocationCoordinate2D) {
        selectedLocation.append(SelectPlaceLocationHolder.from(cllocationCoordinate2D: coordinate))
        let markerBuilder = MapMarkerBuilder()
        $annotate
            .execute(markerBuilder.createMarker(coordinate))
    }
    
    func removeSelectedCoordinates(coordinate: CLLocationCoordinate2D) {
        let loc = SelectPlaceLocationHolder.from(cllocationCoordinate2D: coordinate)
        selectedLocation.removeAll(where: { $0 == loc })
    }
    
    @objc func userDidTapedDelete() {
        selectedLocation.removeAll()
        $clearMap.execute()
    }
    
    @objc func nextTapped() {
        guard selectedLocation.isEmpty.not else {
            coordinatorDelegate?.presentAlert(title: .localize(.data_is_missing).uppercased(),
                                              message: .localize(.choose_at_least_one_location).uppercased(),
                                              actionBtnTitle: .localize(.ok).uppercased())
            return
        }
        coordinatorDelegate?.didSelectedNext(with: selectedLocation)
    }
}
