//
//  TabBarViewController.swift
//  WeatherApp
//
//  Created by Afsal's Macbook Pro on 06/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let index = self.tabBar.items?.firstIndex(of: item), let subView = tabBar.subviews[index+1].subviews.first as? UIImageView {
            self.performSpringAnimation(imgView: subView)
        }
    }
    
    /// unc to perform spring animation on imageview
    /// - Parameter imgView: UIImageView
    func performSpringAnimation(imgView: UIImageView) {
        imgView.animate(from: 1.1, to: 1)
    }
}
