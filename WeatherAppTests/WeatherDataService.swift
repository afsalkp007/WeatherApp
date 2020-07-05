//
//  WeatherDataService.swift
//  WeatherAppTests
//
//  Created by Afsal's Macbook Pro on 04/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import XCTest
@testable import WeatherApp

class WeatherDataServiceTests: XCTestCase {

     func testFetchWeatherData() {
       let expectation = self.expectation(description: #function)
       let mockNetworkService = MockNetworkService(fileName: "weather")
       let weatherDataService = WeatherDataService(networking: mockNetworkService)
        weatherDataService.fetchBookmarkedLocations("", completion: { result in
            switch result {
            case .success(let weather):
                XCTAssertEqual(weather?.weatherCondition?.count, 1)
                        expectation.fulfill()
            case .failure(let error):
                print(error.localizedDescription)
            }
           
       })

       wait(for: [expectation], timeout: 1)
     }

}
