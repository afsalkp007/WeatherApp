//
//  PreferencesOption.swift
//  WeatherApp
//
//  Created by Afsal's Macbook Pro on 03/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import Foundation

protocol PreferencesOption {
  associatedtype PreferencesOptionType
  var value: PreferencesOptionType { get set }
  init(value: PreferencesOptionType)
  init?(rawValue: Int)
  var stringValue: String { get }
}
