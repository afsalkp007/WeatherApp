//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Afsal's Macbook Pro on 05/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit

struct ForecastViewModel {
    var weekday: String?
    var temperature: String?
    var weatherCondition: String?
    var icon: UIImage?
    private let defaultString = "-"
    
    init(model: List) {
        self.weekday = ForecastViewModel.getDayOfWeek(from: model.date ?? 0.0)
        self.weatherCondition = model.weather?[0].conditionName
        self.temperature = "\(ConversionWorker.convertToCelsius(model.atmosphericInformation?.temperatureKelvin ?? 0.0)) \(Constants.Values.TemperatureUnit.kCelsius)"
        let weatherIcon = WeatherIcon(iconString: (model.weather?[0].icon ?? ""))
        self.icon = weatherIcon.image
    }
    
    static func getDayOfWeek(from fromDate: Double) -> String {
        let date = Date(timeIntervalSince1970: fromDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayOfWeekString = dateFormatter.string(from: date)
        
        return dayOfWeekString
    }
}
