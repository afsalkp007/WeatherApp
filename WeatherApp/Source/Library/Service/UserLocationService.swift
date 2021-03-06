//
//  UserLocationService.swift
//  WeatherApp
//
//  Created by Afsal's Macbook Pro on 03/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import CoreLocation

final class UserLocationService: CLLocationManager, CLLocationManagerDelegate {
  
  // MARK: - Public Assets
  
  static var shared: UserLocationService!
  
  var currentLatitude: Double?
  var currentLongitude: Double?
  var authorizationStatus: CLAuthorizationStatus
  
  // MARK: - Intialization
  
  private override init() {
    authorizationStatus = CLLocationManager.authorizationStatus()
    super.init()
  }
  
  // MARK: - Public Methods
  
  static func instantiateSharedInstance() {
    // initialize with example data
    shared = UserLocationService()
    
    UserLocationService.shared.delegate = UserLocationService.shared
    UserLocationService.shared.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    UserLocationService.shared.startUpdatingLocation()
  }
  
  var locationPermissionsGranted: Bool {
    return authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse
  }
  
  var currentLocation: CLLocation? {
    if let latitude = currentLatitude, let longitude = currentLongitude {
      return CLLocation(latitude: latitude, longitude: longitude)
    }
    return nil
  }
  
  // MARK: - Delegate Methods
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    authorizationStatus = status
    if authorizationStatus != .authorizedWhenInUse && authorizationStatus != .authorizedAlways {
      self.currentLatitude = nil
      self.currentLongitude = nil
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let currentLocation = manager.location?.coordinate
    currentLatitude = currentLocation?.latitude
    currentLongitude = currentLocation?.longitude
  }
}
