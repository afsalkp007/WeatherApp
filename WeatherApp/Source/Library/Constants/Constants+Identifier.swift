//
//  Constants+Identifier.swift
//  WeatherApp
//
//  Created by Afsal's Macbook Pro on 05/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import Foundation

extension Constants {
  enum Identifier {}
}

extension Constants.Identifier {
    enum ReuseIdentifier {
        static let kLocationResultCell = "LocationResultCell"
    }
    
    enum ViewController {
        static let kWeatherDetailViewController = "WeatherDetailViewController"
        static let kForecastViewController = "ForcastViewController"
    }
    
    enum Segue {
        static let kShowLocationSearch = "showLocationSearch"
    }
}
