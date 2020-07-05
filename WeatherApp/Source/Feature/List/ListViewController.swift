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
    private var namesArray = [String]()
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Bookmarks"
        setupTableView()
        
        let array = defaults.object(forKey: Constants.Keys.UserDefaults.kSavedNameArray) as? [String]
        namesArray = array ?? []
        namesArray.forEach{ name in
            loadData(with: name)
        }
        
        view.addSubview(emptyView)
        NSLayoutConstraint.pin(view: emptyView, toEdgesOf: view)
        emptyView.alpha = 0
        
        if namesArray.isEmpty {
            setupEmptyView()
        }
    }
    
    private func setupTableView() {
        
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
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
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: Constants.Identifier.ViewController.kWeatherDetailViewController) as? WeatherDetailViewController else { return }
            vc.weatherDTO = weatherDTO
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        }
        
        adapter.edit = { [unowned self] weatherDTO, indexPath in
            self.namesArray = self.namesArray.filter({$0 != weatherDTO.cityName})
            self.defaults.set(self.namesArray, forKey: Constants.Keys.UserDefaults.kSavedNameArray)
            self.adapter.items.remove(at: indexPath.row)
            self.tableView.reloadData()
            self.setupEmptyView()
        }
    }
    
    @objc private func refreshData() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    private func configure(with weather: WeatherInformationDTO, cell: ListCell) {
        cell.cityNameLabel.text = weather.cityName
        
        cell.temperatureLabel.text = "\(ConversionWorker.convertToCelsius(weather.atmosphericInformation?.temperatureKelvin ?? 0.0)) \(Constants.Values.TemperatureUnit.kCelsius)"
    
        
        cell.cloudCoverLabel.text = weather.cloudCoverage?.coverage?.append(contentsOf: "%", delimiter: .none)
        cell.humidityLabel.text = weather.atmosphericInformation?.humidity?.append(contentsOf: "%", delimiter: .none)
        cell.windSpeedLabel.text = "\(weather.windInformation?.windSpeed ?? 0.0) km/h"
    }
    
    private func loadData(with cityName: String) {
        refreshControl.beginRefreshing()
        weatherService.fetchBookmarkedLocations(cityName, completion: { [weak self] result in
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.Identifier.Segue.kShowLocationSearch {
            
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetViewController = destinationNavigationController.topViewController as! LocationSearchController
            targetViewController.delegate = self
            
        }
    }
    
    private func handle(_ weather: WeatherInformationDTO?) {
        guard let weather = weather else {
            setupEmptyView()
            return
        }
        
        adapter.items.append(weather)
        tableView.reloadData()
        setupEmptyView()
    }
    
    func setupEmptyView() {
        UIView.animate(withDuration: 0.25, animations: {
            self.emptyView.alpha = self.adapter.items.isEmpty ? 1 : 0
        })
    }
}

extension ListViewController: ChangeLocationDelegate {
    func newLocationEntered(name: String) {
        namesArray.append(name)
        defaults.set(namesArray, forKey: Constants.Keys.UserDefaults.kSavedNameArray)
        loadData(with: name)
    }
}
