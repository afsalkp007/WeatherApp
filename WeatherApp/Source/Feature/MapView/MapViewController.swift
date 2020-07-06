//
//  MapViewController.swift
//  WeatherApp
//
//  Created by Afsal's Macbook Pro on 05/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var mapView: MKMapView!
    private let weatherService = WeatherDataService(networking: NetworkService())
    private var weatherObjects = [WeatherInformationDTO]()
    
    // MARK: - Properties
    
    private var weatherLocationMapAnnotations: [WeatherLocationMapAnnotation]?
    private var previousRegion: MKCoordinateRegion?
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = TitleManager.tab_weatherMap.localized
        
        configureMapView()
        getNearbyLocations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        focusOnAvailableLocation()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func getNearbyLocations() {
        guard UserLocationService.shared.locationPermissionsGranted, let location = UserLocationService.shared.currentLocation else {
            return
        }
        weatherService.fetchNearbyLocations(location.coordinate, completion: { [weak self] result in
            switch result {
            case .success(let lists):
                self?.weatherObjects = lists ?? []
                let annotations = lists?.compactMap(WeatherLocationMapAnnotation.init)
                self?.configureMapAnnotations(with: annotations)
            case .failure(let error):
                print("Failed with error: \(error.localizedDescription)")
            }
        })
    }
}

    // MARK: - Private Helpers

private extension MapViewController {
    
    func configureMapAnnotations(with annotations: [WeatherLocationMapAnnotation]?) {
        // remove previous annotations
        mapView.annotations.forEach { mapView.removeAnnotation($0) }
        
        // calculate current annotations
        weatherLocationMapAnnotations = annotations
        
        // add current annotations
        mapView.addAnnotations(weatherLocationMapAnnotations ?? [])
    }
    
    func focusMapOnUserLocation() {
        if UserLocationService.shared.locationPermissionsGranted, let currentLocation = UserLocationService.shared.currentLocation {
            let region = MKCoordinateRegion.init(center: currentLocation.coordinate, latitudinalMeters: 25000, longitudinalMeters: 25000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func focusOnAvailableLocation() {
        if let previousRegion = previousRegion {
            mapView.setRegion(previousRegion, animated: true)
            return
        }
        guard UserLocationService.shared.locationPermissionsGranted, UserLocationService.shared.currentLocation != nil else {
            return
        }
        focusMapOnUserLocation()
    }
    
    func configureMapView() {
        
        mapView.delegate = self
        mapView.mapType = .standard
    }
}

    // MARK: - Target Functions

private extension MapViewController {
    
    @objc private func reconfigureOnWeatherDataServiceDidUpdate() {
        //configureMapAnnotations()
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? WeatherLocationMapAnnotation else {
            return nil
        }
        
        var viewForCurrentAnnotation: WeatherLocationMapAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.Keys.MapAnnotation.kMapAnnotationViewIdentifier) as? WeatherLocationMapAnnotationView {
            viewForCurrentAnnotation = dequeuedAnnotationView
        } else {
            viewForCurrentAnnotation = WeatherLocationMapAnnotationView(frame: kMapAnnotationViewInitialFrame)
        }
        
        let fillColor = UIColor.white
        let textColor = UIColor.black
        
        viewForCurrentAnnotation?.annotation = annotation
        viewForCurrentAnnotation?.configure(
            withTitle: annotation.title ?? Constants.Messages.kNotSet,
            subtitle: annotation.subtitle ?? Constants.Messages.kNotSet,
            fillColor: fillColor,
            textColor: textColor,
            tapHandler: { [weak self] _ in
                self?.previousRegion = mapView.region
                self?.goToDetailView(with: annotation.locationId)
            }
        )
        return viewForCurrentAnnotation
    }
        
    private func goToDetailView(with identifier: Int) {
        let weatherObj = self.weatherObjects.first(where: {$0.cityID == identifier})
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: Constants.Identifier.ViewController.kWeatherDetailViewController) as? WeatherDetailViewController else { return }
        vc.weatherDTO = weatherObj
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.isTranslucent = false
        nav.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.4797251225, blue: 0.7055471539, alpha: 1)
        nav.navigationBar.tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]

        
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
    
}
