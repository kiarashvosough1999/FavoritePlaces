//
//  SelectPlaceViewController.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/6/1400 AP.
//

import Foundation
import GoogleMaps

final class SelectPlaceViewController: UIViewController, ViewProtocol, MVVMView {
    
    var viewModel: SelectPlaceViewModel!
    
    fileprivate let viewMaker = ViewMaker()
    
    // MARK: - Views
    
    fileprivate lazy var markers: [GMSMarker] = []
    
    fileprivate lazy var mapView = viewMaker
        .GMView
        .with(style: AppStyle.GMSMap().favoritePlacesMap())
        .set(\.delegate, to: self)
    
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
    }
    
    func setupBindings() {
        
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
        
        title = viewModel.title
        
        view.backgroundColor = .white
        
        let navDeleteItem = UIBarButtonItem(image: UIImage(systemName: "trash.fill"),
                                            style: .plain,
                                            target: viewModel,
                                            action: #selector(viewModel.userDidTapedDelete))
        
        let saveDeleteItem = UIBarButtonItem(barButtonSystemItem: .save,
                                             target: viewModel,
                                             action: #selector(viewModel.nextTapped))
        
        navigationItem.rightBarButtonItems = [saveDeleteItem, navDeleteItem]
    }
    
    func constraintViews() {
        addViews(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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

// MARK: - GMSMapViewDelegate

extension SelectPlaceViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        viewModel.didTapAt(coordinate: coordinate)
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        marker.map = nil
        markers.removeAll(where: {$0 == marker })
        viewModel.removeSelectedCoordinates(coordinate: marker.position)
        return true
    }
}
