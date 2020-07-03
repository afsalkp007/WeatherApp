//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Afsal's Macbook Pro on 03/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit
import MapKit
//import APTimeZones

class WeatherDetailViewController: UIViewController {
    
    var weatherDTO: WeatherInformationDTO!
    @IBOutlet weak var coordinatesNoteLabel: UILabel!
    @IBOutlet weak var distanceNoteLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var conditionSymbolLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var cloudCoverLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var conditionNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionDescriptionLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var coordinatesLabel: UILabel!
    var preferredMapType: MKMapType = .standard
    
    @IBOutlet weak var timeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = weatherDTO.cityName
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: R.image.verticalCloseButton(),
            style: .plain,
            target: self,
            action: #selector(Self.dismissButtonTapped))
        
        mapView.mapType = preferredMapType
        mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configure()
    }
    
    private func configure() {
        
        let isDayTime = ConversionWorker.isDayTime(for: weatherDTO.dayInformation, coordinates: weatherDTO.coordinates) ?? true
        conditionSymbolLabel.text = ConversionWorker.weatherConditionSymbol(
          fromWeatherCode: weatherDTO.weatherCondition[0].identifier,
          isDayTime: isDayTime
        )
        
        conditionNameLabel.text = weatherDTO.weatherCondition.first?.conditionName
        conditionDescriptionLabel.text = weatherDTO.weatherCondition.first?.description?.capitalized
        temperatureLabel.text = "\(ConversionWorker.convertToCelsius(weatherDTO.atmosphericInformation.temperatureKelvin ?? 0.0)) \(Constants.Values.TemperatureUnit.kCelsius)"
        
        if let sunriseTimeSinceReferenceDate = weatherDTO?.dayInformation.sunrise,
            let sunsetTimeSinceReferenceDate = weatherDTO?.dayInformation.sunset,
            let latitude = weatherDTO?.coordinates.latitude,
            let longitude = weatherDTO?.coordinates.longitude {
            let sunriseDate = Date(timeIntervalSince1970: sunriseTimeSinceReferenceDate)
            let sunsetDate = Date(timeIntervalSince1970: sunsetTimeSinceReferenceDate)
            
            let location = CLLocation(latitude: latitude, longitude: longitude)
            
            let dateFormatter = DateFormatter()
            dateFormatter.calendar = .current
            //dateFormatter.timeZone = location.timeZone()
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = .short
            
            sunriseLabel.text = dateFormatter.string(from: sunriseDate)
            sunsetLabel.text = dateFormatter.string(from: sunsetDate)
        }
        
        cloudCoverLabel.text = weatherDTO?.cloudCoverage.coverage?.append(contentsOf: "%", delimiter: .none)
        humidityLabel.text = weatherDTO?.atmosphericInformation.humidity?.append(contentsOf: "%", delimiter: .none)
        pressureLabel.text = weatherDTO?.atmosphericInformation.pressurePsi?.append(contentsOf: "hpa", delimiter: .space)
        
        if let windspeed = weatherDTO?.windInformation.windSpeed {
            windSpeedLabel.text = "\(windspeed) \(R.string.localizable.kph())"
        }
        
        if let windDirection = weatherDTO?.windInformation.degree {
            windSpeedLabel.text = "\(windDirection)"
        }
        
        coordinatesNoteLabel.text = R.string.localizable.coordinates()
        coordinatesLabel.text = ""
          .append(contentsOfConvertible: weatherDTO.coordinates.latitude, delimiter: .none)
          .append(contentsOfConvertible: weatherDTO.coordinates.longitude, delimiter: .comma)
        
     
    }
    
    @objc private func dismissButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }

    @IBAction func openWeatherButtonPressed(_ sender: UIButton) {
        presentSafariViewController(for:
          Constants.Urls.kOpenWeatherMapCityDetailsUrl(forCityWithName: weatherDTO.cityName)
        )
    }
}

extension WeatherDetailViewController: MKMapViewDelegate {
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard let annotation = annotation as? WeatherLocationMapAnnotation else {
      return nil
    }
    
    var viewForCurrentAnnotation: WeatherLocationMapAnnotationView?
    if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.Keys.MapAnnotation.kMapAnnotationViewIdentifier) as? WeatherLocationMapAnnotationView {
      viewForCurrentAnnotation = dequeuedAnnotationView
    } else {
      viewForCurrentAnnotation = WeatherLocationMapAnnotationView(frame: kMapAnnotationViewInitialFrame)
    }
    
    var fillColor: UIColor
    var textColor: UIColor
    
      fillColor = annotation.isDayTime ?? true
        ? Constants.Theme.Color.BrandColors.standardDay
        : Constants.Theme.Color.BrandColors.standardNight // default to blue colored cells
      
      textColor = .white
    
    
    viewForCurrentAnnotation?.annotation = annotation
    viewForCurrentAnnotation?.configure(
      withTitle: annotation.title ?? Constants.Messages.kNotSet,
      subtitle: annotation.subtitle ?? Constants.Messages.kNotSet,
      fillColor: fillColor,
      textColor: textColor,
      tapHandler: nil
    )
    return viewForCurrentAnnotation
  }
}

