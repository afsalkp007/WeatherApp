//
//  NSLayoutConstraint.swift
//  WeatherApp
//
//  Created by Afsal's Macbook Pro on 03/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
  /// Activate constraints
  ///
  /// - Parameter constraints: An array of constraints
  static func activate(_ constraints: [NSLayoutConstraint]) {
    constraints.forEach {
      ($0.firstItem as? UIView)?.translatesAutoresizingMaskIntoConstraints = false
      $0.isActive = true
    }
  }

  static func pin(view: UIView, toEdgesOf anotherView: UIView) {
    activate([
      view.topAnchor.constraint(equalTo: anotherView.topAnchor),
      view.leftAnchor.constraint(equalTo: anotherView.leftAnchor),
      view.rightAnchor.constraint(equalTo: anotherView.rightAnchor),
      view.bottomAnchor.constraint(equalTo: anotherView.bottomAnchor)
    ])
  }
}
