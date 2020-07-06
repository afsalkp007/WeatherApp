//
//  Array+Ext.swift
//  WeatherApp
//
//  Created by Afsal's Macbook Pro on 06/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import Foundation

extension Array {
    func filterDuplicate(_ keyValue:((AnyHashable...)->AnyHashable,Element)->AnyHashable) -> [Element] {
        func makeHash(_ params:AnyHashable ...) -> AnyHashable {
           var hash = Hasher()
           params.forEach{ hash.combine($0) }
           return hash.finalize()
        }
        var uniqueKeys = Set<AnyHashable>()
        return filter{uniqueKeys.insert(keyValue(makeHash,$0)).inserted}
    }
}
