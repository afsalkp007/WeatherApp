//
//  AddFavouriteViewController.swift
//  WeatherApp
//
//  Created by Afsal's Macbook Pro on 03/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit
import MapKit

class AddFavouriteViewController: UIViewController {

  /// When a recipe get select
  var select: ((WeatherInformationDTO) -> Void)?

  private let weatherDataService: WeatherDataService
  private let searchComponent: SearchComponent
  private let searchListViewController = SearchListViewController()

  // MARK: - Init

  required init(weatherDataService: WeatherDataService) {
    self.weatherDataService = weatherDataService
    self.searchComponent = SearchComponent(weatherDataService: weatherDataService)
    super.init(nibName: nil, bundle: nil)
    self.title = "Add Bookmark"
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }

  // MARK: - View life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
    setupSearch()
  }

  // MARK: - Setup

  private func setup() {
    searchListViewController.delegate = self
    searchListViewController.adapterCollection.select = select
    add(childViewController: searchListViewController)
  }

  private func setupSearch() {
    searchComponent.add(to: self)
    searchComponent.searchListViewController.adapterCollection.select = select
  }
}

extension AddFavouriteViewController: SearchListDelegate {
    func dismissAddFavouriteView() {
        self.dismiss(animated: true)
    }
}



