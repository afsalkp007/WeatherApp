//
//  Adapter.swift
//  WeatherApp
//
//  Created by Afsal's Macbook Pro on 03/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit


class Adapter<T, Cell: UITableViewCell>: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var items: [T] = []
    var configure: ((T, Cell) -> Void)?
    var select: ((T) -> Void)?
    var cellHeight: CGFloat = 100.0
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: Cell = tableView.dequeue(indexPath)
        let item = items[indexPath.row]
        configure?(item, cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        select?(item)
    }
    
}
