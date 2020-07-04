//
//  WeatherDataTests.swift
//  WeatherAppTests
//
//  Created by Afsal's Macbook Pro on 04/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import XCTest
@testable import WeatherApp

class WeatherDataTests: XCTestCase {

    func testParsing() throws {
      let json: [String: Any] = [
        
            "coord": [
                "lon": 55.3,
                "lat": 25.26
            ],
            "weather": [
                [
                    "id": 802,
                    "main": "Clouds",
                    "description": "scattered clouds",
                    "icon": "03n"
                ]
            ],
            "base": "stations",
            "main": [
                "temp": 309.74,
                "feels_like": 315.13,
                "temp_min": 309.15,
                "temp_max": 310.15,
                "pressure": 994,
                "humidity": 50
            ],
            "visibility": 10000,
            "wind": [
                "speed": 1,
                "deg": 0
            ],
            "clouds": [
                "all": 42
            ],
            "dt": 1593884917,
            "sys": [
                "type": 1,
                "id": 7537,
                "country": "AE",
                "sunrise": 1593826387,
                "sunset": 1593875581
            ],
            "timezone": 14400,
            "id": 292223,
            "name": "Dubai",
            "cod": 200
        ]
      

      let data = try JSONSerialization.data(withJSONObject: json, options: [])
      let decoder = JSONDecoder()
      let weather = try decoder.decode(WeatherInformationDTO.self, from: data)

        XCTAssertEqual(weather.cityName, "Dubai")
        XCTAssertEqual(weather.cityID, 292223)
        XCTAssertEqual(weather.timezone, 14400)
    }


}
