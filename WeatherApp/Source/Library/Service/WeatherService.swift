//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Afsal's Macbook Pro on 03/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

final class WeatherService {
    
    private let baseUrl = URL(string: "https://api.openweathermap.org")!
    private let apiKey = "c6e381d8c7ff98f0fee43775817cf6ad"
    
    private let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    /// Fetch restaurant data
    /// - Parameter completion: Called when operation finishes
    func fetchBookmarkedLocations(_ location: String, completion: @escaping (Result<WeatherData?>) -> Void) {
        let resource = Resource(url: baseUrl, path: "data/2.5/weather", parameters:
            ["q": location,
             "appid": apiKey
            ])
        
        _ = networking.fetch(resource: resource, completion: { data in
            DispatchQueue.main.async {
                completion(.success(data.flatMap({ WeatherData.make(data: $0) }) ))
            }
        })
    }
}



