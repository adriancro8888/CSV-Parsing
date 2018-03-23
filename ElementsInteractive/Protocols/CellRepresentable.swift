//
//  CellRepresentable.swift
//  DemoApp
//
//  Created by Shabir Jan on 3/11/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import UIKit
protocol CellRepresentable {
    static func registerCell(tableView: UITableView)
    func dequeueCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func cellSelected()
}
