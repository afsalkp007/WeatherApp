//
//  UICollectionView+Ext.swift
//  WeatherApp
//
//  Created by Afsal's Macbook Pro on 03/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit

extension UICollectionView {

  /// Generic function to dequeue cell
  func dequeue<Cell: UICollectionViewCell>(indexPath: IndexPath) -> Cell {
    // swiftlint:disable force_cast
    return dequeueReusableCell(withReuseIdentifier: String(describing: Cell.self), for: indexPath) as! Cell
  }

  /// Generic function to register cell
  func register(cellType: UICollectionViewCell.Type) {
    register(cellType, forCellWithReuseIdentifier: String(describing: cellType.self))
  }
}
