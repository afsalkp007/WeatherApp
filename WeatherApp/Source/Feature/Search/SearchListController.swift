//
//  SearchListController.swift
//  WeatherApp
//
//  Created by Afsal's Macbook Pro on 03/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit

protocol SearchListDelegate: class {
    func dismissAddFavouriteView()
}

final class SearchListViewController: UIViewController {
  private(set) var collectionView: UICollectionView!
  let adapterCollection = AdapterCollection<WeatherInformationDTO, SearchCell>()
    weak var delegate: SearchListDelegate?

  // MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }

  private func setup() {
    view.backgroundColor = .white

    let layout = UICollectionViewFlowLayout()
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.dataSource = adapterCollection
    collectionView.delegate = adapterCollection
    collectionView.register(cellType: SearchCell.self)
    collectionView.backgroundColor = .clear
    collectionView.contentInset.top = 8
    collectionView.alwaysBounceVertical = true

    adapterCollection.configure = { weather, cell in
        cell.titleLabel.text = weather.cityName
    }
    
    adapterCollection.select = { [weak self] weather in
        print(weather)
        self?.delegate?.dismissAddFavouriteView()
    }

    view.addSubview(collectionView)
    NSLayoutConstraint.pin(view: collectionView, toEdgesOf: view)
  }

  func handle(weather: WeatherInformationDTO) {
    adapterCollection.items.removeAll()
    adapterCollection.items.append(weather)
    collectionView.reloadData()
  }
}

