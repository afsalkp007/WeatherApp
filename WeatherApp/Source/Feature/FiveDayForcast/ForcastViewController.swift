//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Afsal's Macbook Pro on 05/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit

class ForcastViewController: UIViewController {
    
    // MARK: - Variables
    var weatherDTO: WeatherInformationDTO?
    @IBOutlet weak var tableView: UITableView!
    private let weatherService = WeatherDataService(networking: NetworkService())
    private let viewModels = [ForecastViewModel]()
    private let adapter = Adapter<ForecastViewModel, ForecastDayTableViewCell>()
    private let emptyView = EmptyView(text: TitleManager.no_data_found.localized)

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = weatherDTO?.cityName
        getFiveDayForecaset(weatherDTO?.cityName ?? "")
        
        adapter.cellHeight = 90.0
        tableView.delegate = adapter
        tableView.dataSource = adapter
        tableView.layer.cornerRadius = 0
        tableView.backgroundColor = UIColor.clear
        
        adapter.configure = { item, cell in
            cell.weatherConditionImageView.image = item.icon
            cell.weekdayLabel.text = item.weekday
            cell.weatherConditionLabel.text = item.weatherCondition
            cell.temperatureLabel.text = item.temperature
        }
        
        view.addSubview(emptyView)
        NSLayoutConstraint.pin(view: emptyView, toEdgesOf: view)
        emptyView.alpha = 0
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
        tableView.separatorStyle = adapter.items.isEmpty ? .none : .singleLine
        tableView.reloadData()
        
        setupEmptyView()
    }
    
    private func setupEmptyView() {
        UIView.animate(withDuration: 0.25, animations: {
            self.emptyView.alpha = self.adapter.items.isEmpty ? 1 : 0
        })
    }

}
