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
        guard let index = self.tabBar.items?.firstIndex(of: item) else { return }
        if let subView = tabBar.subviews[index+1].subviews.first as? UIImageView {
            self.performSpringAnimation(imgView: subView)
        }
    }
    
    /// unc to perform spring animation on imageview
    /// - Parameter imgView: UIImageView
    func performSpringAnimation(imgView: UIImageView) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            
            imgView.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
            UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                imgView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            })
        })
    }
}
