//
//  MockNetworkService.swift
//  WeatherApp
//
//  Created by Afsal's Macbook Pro on 03/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import Foundation
@testable import WeatherApp

final class MockNetworkService: Networking {
  let data: Data
  init(fileName: String) {
    let bundle = Bundle(for: MockNetworkService.self)
    let url = bundle.url(forResource: fileName, withExtension: "json")!
    self.data = try! Data(contentsOf: url)
  }

  func fetch(resource: Resource, completion: @escaping (Data?) -> Void) -> URLSessionTask? {
    completion(data)
    return nil
  }
}
