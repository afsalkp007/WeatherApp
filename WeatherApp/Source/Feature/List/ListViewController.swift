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
    private let weatherService = WeatherDataService(networking: NetworkService())
    private let adapter = Adapter<WeatherInformationDTO, ListCell>()
    private var refreshControl = UIRefreshControl()
     private let emptyView = EmptyView(text: "No cities found!, Add some cities as Favourites")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Bookmarks"
        setupTableView()
        loadData()
    }
    
    private func setupTableView() {
        
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        tableView.register(cellType: ListCell.self)
        
        tableView.layer.cornerRadius = 0
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        
        tableView.delegate = adapter
        tableView.dataSource = adapter
        
        adapter.configure = { [weak self] weather, cell in
            self?.configure(with: weather, cell: cell)
        }
        
        adapter.select = { [unowned self] weatherDTO in
            guard let vc = R.storyboard.main.weatherDetailViewController() else { return }
            vc.weatherDTO = weatherDTO
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        }
    }
    
    private func configure(with weather: WeatherInformationDTO, cell: ListCell) {
        cell.cityNameLabel.text = weather.cityName
        
        cell.temperatureLabel.text = "\(ConversionWorker.convertToCelsius(weather.atmosphericInformation.temperatureKelvin ?? 0.0)) \(Constants.Values.TemperatureUnit.kCelsius)"
    
        
        cell.cloudCoverLabel.text = weather.cloudCoverage.coverage?.append(contentsOf: "%", delimiter: .none)
        cell.humidityLabel.text = weather.atmosphericInformation.humidity?.append(contentsOf: "%", delimiter: .none)
        cell.windSpeedLabel.text = "\(weather.windInformation.windSpeed ?? 0.0) km/h"
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
    
    @IBAction func addBookmark(_ sender: UIBarButtonItem) {
        let viewController = AddFavouriteViewController(weatherDataService: weatherService)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func handle(_ weather: WeatherInformationDTO?) {
        guard let weather = weather else { return }
        adapter.items.append(weather)
      tableView.reloadData()

      UIView.animate(withDuration: 0.25, animations: {
        self.emptyView.alpha = self.adapter.items.isEmpty ? 1 : 0
      })
    }
}
