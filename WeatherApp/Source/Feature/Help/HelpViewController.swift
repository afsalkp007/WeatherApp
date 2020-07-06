//
//  HelpViewController.swift
//  WeatherApp
//
//  Created by Afsal's Macbook Pro on 06/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let image = UIImage(named: Constants.Image.name.kVerticalCloseButton)?.withRenderingMode(.alwaysTemplate)
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: image,
            style: .plain,
            target: self,
            action: #selector(Self.dismissButtonTapped))
        
        webView.loadHTMLString("""
<p>iOS Weather App using OpenWeatherMap API.</p>
        <p>WeatherApp is a simple weather app, that provides current weather information for nearby cities, as well for bookmarked locations. WeatherApp uses the OpenWeatherMap API to download weather data.</p>
        <p>With WeatherApp you can:</p>
        <ul>
        <li>See current weather information for bookmarked and nearby places via a list and a map view</li>
        <li>Get Weather details by clicking on nearby places on map view</li>
        <li>Detailed weather information is offered in addition to the overviews</li>
        <li>Search Locations and Add places as bookmarks</li>
        <li>Swipe to delete Bookmarks</li>
        <li>Detailed Five day Weather Forecast</li>
        </ul>
""", baseURL: nil)
    }
    
    @objc private func dismissButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
}
