//
//  TemperatureUnitValue.swift
//  WeatherApp
//
//  Created by Afsal's Macbook Pro on 03/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import Foundation

enum TemperatureUnitValue: Int, CaseIterable, Codable {
  case celsius
  case fahrenheit
  case kelvin
}

struct TemperatureUnitOption: Codable, PreferencesOption {
  static let availableOptions = [TemperatureUnitOption(value: .celsius),
                                 TemperatureUnitOption(value: .fahrenheit),
                                 TemperatureUnitOption(value: .kelvin)]
  
  typealias PreferencesOptionType = TemperatureUnitValue
  
  private lazy var count: Int = {
    return TemperatureUnitValue.allCases.count
  }()
  
  var value: TemperatureUnitValue
  
  init(value: TemperatureUnitValue) {
    self.value = value
  }
  
  init?(rawValue: Int) {
    guard let value = TemperatureUnitValue(rawValue: rawValue) else {
      return nil
    }
    self.init(value: value)
  }
  
  var stringValue: String {
    switch value {
    case .celsius: return Constants.Values.TemperatureName.kCelsius
    case .fahrenheit: return Constants.Values.TemperatureName.kFahrenheit
    case .kelvin: return Constants.Values.TemperatureName.kKelvin
    }
  }
  
  var abbreviation: String {
    switch value {
    case .celsius: return Constants.Values.TemperatureUnit.kCelsius
    case .fahrenheit: return Constants.Values.TemperatureUnit.kFahrenheit
    case .kelvin: return Constants.Values.TemperatureUnit.kKelvin
    }
  }
}
