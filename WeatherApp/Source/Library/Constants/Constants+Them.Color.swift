//
//  Constants+Them.Color.swift
//  WeatherApp
//
//  Created by Afsal's Macbook Pro on 03/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit

extension Constants.Theme {
  enum Color {}
}

extension Constants.Theme.Color {
    
    enum BrandColors { // TODO rename
        
        static var standardDay: UIColor {
            UIColor.from(dark: .init(hex: 0x64aff5),
                         light: .init(hex: 0x50B4FA))
        }
        
        static var standardNight: UIColor {
            UIColor.from(dark: .init(hex: 0x3f709b),
                         light: .init(hex: 0x32719C))
        }
    }
    
    enum ContentElement {
      
      static var title: UIColor {
        UIColor.from(dark: .init(hex: 0xFFFFFF),
                     light: .init(hex: 0x000000))
      }
    }
    
}
