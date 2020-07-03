//
//  SearchComponent.swift
//  WeatherApp
//
//  Created by Afsal's Macbook Pro on 03/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit

/// A reusable component to add search functionality via search bar
final class SearchComponent: NSObject, UISearchResultsUpdating, UISearchBarDelegate {
  let weatherDataService: WeatherDataService
  let searchController: UISearchController
    let searchListViewController = SearchListViewController()
  var task: URLSessionTask?
  private lazy var loadingIndicator: UIActivityIndicatorView = self.makeLoadingIndicator()

  /// Avoid making lots of requests when user types fast
  /// This throttles the search requests
  let debouncer = Debouncer(delay: 2)

  required init(weatherDataService: WeatherDataService) {
    self.weatherDataService = weatherDataService
    self.searchController = UISearchController(searchResultsController: searchListViewController)
    super.init()
    searchController.searchResultsUpdater = self
    searchController.searchBar.delegate = self
    searchController.dimsBackgroundDuringPresentation = true
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.searchBar.placeholder = "Search city"

    searchListViewController.view.addSubview(loadingIndicator)
    NSLayoutConstraint.activate([
      loadingIndicator.centerXAnchor.constraint(equalTo: searchListViewController.view.centerXAnchor),
      loadingIndicator.centerYAnchor.constraint(equalTo: searchListViewController.view.centerYAnchor, constant: -100)
    ])
  }

  /// Add search bar to view controller
  func add(to viewController: UIViewController) {
    if #available(iOS 11, *) {
      viewController.navigationItem.searchController = searchController
      viewController.navigationItem.hidesSearchBarWhenScrolling = false
    } else {
      viewController.navigationItem.titleView = searchController.searchBar
    }

    viewController.definesPresentationContext = true
  }

  // MARK: - UISearchResultsUpdating

  func updateSearchResults(for searchController: UISearchController) {
    // No op
  }

  // MARK: - UISearchBarDelegate

  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    debouncer.schedule { [weak self] in
      self?.performSearch()
    }
  }

  // MARK: - Logic

  private func performSearch() {
    guard let text = searchController.searchBar.text, !text.isEmpty else {
      return
    }

    search(query: text)
  }

  private func search(query: String) {
    task?.cancel()
    loadingIndicator.startAnimating()
    task = weatherDataService.search(query: query, completion: { [weak self] result in
        switch result {
        case .success(let weatherData):
            self?.loadingIndicator.stopAnimating()
            guard let weatherData = weatherData else { return }
            self?.searchListViewController.handle(weather: weatherData)
        case .failure(let error):
            print("Failed with error: \(error.localizedDescription)")
        }
      
    })
  }

  // MARK: - Make

  private func makeLoadingIndicator() -> UIActivityIndicatorView {
    let view = UIActivityIndicatorView(style: .whiteLarge)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.color = .darkGray
    view.hidesWhenStopped = true
    return view
  }
}
