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

final class WeatherDataService {
    
    private let apiKey = "c6e381d8c7ff98f0fee43775817cf6ad"
    
    private let networking: Networking
    
    private(set) var bookmarkedWeatherDataObjects: [WeatherInformationDTO]?
    private(set) var nearbyWeatherDataObject: WeatherInformationDTO?
    
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    
    /// Fetch restaurant data
    /// - Parameter completion: Called when operation finishes
    func fetchBookmarkedLocations(_ location: String, completion: @escaping (Result<WeatherInformationDTO?>) -> Void) {
        let resource = Resource(url: Constants.Urls.kOpenWeatherBaseUrl, path: "data/2.5/weather", parameters:
            ["q": location,
             "appid": apiKey
        ])
        
        _ = networking.fetch(resource: resource, completion: { data in
            DispatchQueue.main.async {
                completion(.success(data.flatMap({ WeatherInformationDTO.make(data: $0) }) ))
            }
        })
    }
    
    /// Search city based on query
    ///
    /// - Parameters:
    ///   - query: The search query
    ///   - completion: Called when operation finishes
    /// - Returns: The network task
    @discardableResult func search(query: String, completion: @escaping (Result<WeatherInformationDTO?>) -> Void) -> URLSessionTask? {
        let resource = Resource(url: Constants.Urls.kOpenWeatherBaseUrl, path: "data/2.5/weather", parameters: ["q": query,
            "appid": apiKey
        ])
        
        return networking.fetch(resource: resource, completion: { data in
            DispatchQueue.main.async {
                completion(.success(data.flatMap({ WeatherInformationDTO.make(data: $0) }) ))
            }
        })
    }
}




