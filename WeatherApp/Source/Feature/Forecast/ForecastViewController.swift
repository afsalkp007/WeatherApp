//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Afsal's Macbook Pro on 05/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit

class ForecastViewController: UITableViewController {
    
    // MARK: - Variables
    var weatherDTO: WeatherInformationDTO?
    private let weatherService = WeatherDataService(networking: NetworkService())
    private let viewModels = [ForecastViewModel]()
    private let adapter = Adapter<ForecastViewModel, ForecastDayTableViewCell>()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = weatherDTO?.cityName
        getFiveDayForecaset(weatherDTO?.cityName ?? "")
        
        adapter.cellHeight = 90.0
        tableView.delegate = adapter
        tableView.dataSource = adapter
        
        adapter.configure = { item, cell in
            cell.weatherConditionImageView.image = item.icon
            cell.weekdayLabel.text = item.weekday
            cell.weatherConditionLabel.text = item.weatherCondition
            cell.temperatureLabel.text = item.temperature
        }
    }
    
    // MARK: - API
    private func getFiveDayForecaset(_ cityName: String) {
        weatherService.fetchFiveDayForecast(cityName, completion: { [weak self] result in
            switch result {
            case .success(let lists):
                let viewModels = lists?.compactMap(ForecastViewModel.init)
                self?.handle(viewModels ?? [])
            case .failure(let error):
                print("Failed with error: \(error.localizedDescription)")
            }
        })
    }
    
    private func handle(_ vm: [ForecastViewModel]) {
        adapter.items = vm
        tableView.reloadData()
    }

}
