//
//  DebouncerTests.swift
//  WeatherAppTests
//
//  Created by Afsal's Macbook Pro on 04/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import XCTest
@testable import WeatherApp

class DebouncerTests: XCTestCase {

   func testDebouncing() {
    let cancelExpectation = self.expectation(description: "cancel")
    cancelExpectation.isInverted = true

    let completeExpectation = self.expectation(description: "complete")
    let debouncer = Debouncer(delay: 0.1)

    debouncer.schedule {
      cancelExpectation.fulfill()
    }

    debouncer.schedule {
      completeExpectation.fulfill()
    }

    wait(for: [cancelExpectation, completeExpectation], timeout: 1)
    }
}
