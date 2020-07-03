//
//  UITableView+Ext.swift
//  WeatherApp
//
//  Created by Afsal's Macbook Pro on 03/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit


extension UITableView {
    
    func dequeue<Cell: UITableViewCell>(_ indexPath: IndexPath) -> Cell {
        return dequeueReusableCell(withIdentifier: String(describing: Cell.self), for: indexPath) as! Cell
    }
    
    func register(cellType: UITableViewCell.Type) {
        register(cellType, forCellReuseIdentifier: String(describing: cellType))
    }
}
