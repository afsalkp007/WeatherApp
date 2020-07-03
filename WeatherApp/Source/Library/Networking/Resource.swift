//
//  Resource.swift
//  WeatherApp
//
//  Created by Afsal's Macbook Pro on 03/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import Foundation

// A network resource, identified by url and parameters
struct Resource {
    let url: URL
    let path: String?
    let httpMethod: String
    let parameters: [String: String]
    let headers: [String: String]
    
    init(url: URL, path: String? = nil, httpMethod: String = "GET", parameters: [String: String] = [:], headers: [String: String] = [:]) {
        self.url = url
        self.path = path
        self.httpMethod = httpMethod
        self.parameters = parameters
        self.headers = headers
  }
}
