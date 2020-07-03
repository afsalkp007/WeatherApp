//
//  ListViewController.swift
//  WeatherApp
//
//  Created by Afsal's Macbook Pro on 03/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let weatherService = WeatherService(networking: NetworkService())
    private let adapter = Adapter<WeatherData, ListCell>()
    private var refreshControl = UIRefreshControl()
     private let emptyView = EmptyView(text: "No recipes found!")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        let nib = UINib(nibName: "ListCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ListCell")
        
        tableView.layer.cornerRadius = 0
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        
        loadData()
        
        tableView.delegate = adapter
        tableView.dataSource = adapter
        
        adapter.configure = { [weak self] weather, cell in
            self?.configure(with: weather, cell: cell)
        }
        
    }
    
    private func configure(with weather: WeatherData, cell: ListCell) {
        cell.cityNameLabel.text = weather.cityName
        
        cell.temperatureLabel.text = "\(ConversionWorker.convertToCelsius(weather.atmosphericInformation.temperatureKelvin ?? 0.0)) \(Constants.Values.TemperatureUnit.kCelsius)"
    
        
        cell.cloudCoverLabel.text = weather.cloudCoverage.coverage?.append(contentsOf: "%", delimiter: .none)
        cell.humidityLabel.text = weather.atmosphericInformation.humidity?.append(contentsOf: "%", delimiter: .none)
        cell.windSpeedLabel.text = "\(weather.windInformation.speed ?? 0.0) km/h"
    }
    
    private func loadData() {
        refreshControl.beginRefreshing()
        weatherService.fetchBookmarkedLocations("dubai", completion: { [weak self] result in
            switch result {
            case .success(let weather):
                self?.handle(weather)
                self?.refreshControl.endRefreshing()
            case .failure(let error):
                print(error.localizedDescription)
                self?.refreshControl.endRefreshing()
            }
        })
    }
    
    // MARK: - Action

    @objc private func refresh() {
      loadData()
    }
    
    private func handle(_ weather: WeatherData?) {
        guard let weather = weather else { return }
        adapter.items.append(weather)
      tableView.reloadData()

      UIView.animate(withDuration: 0.25, animations: {
        self.emptyView.alpha = self.adapter.items.isEmpty ? 1 : 0
      })
    }
}
