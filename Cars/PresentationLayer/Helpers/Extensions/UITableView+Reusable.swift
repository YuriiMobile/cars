//
//  UITableView+Reusable.swift
//  Cars
//
//  Created by Yurii on 13.09.2018.
//  Copyright © 2018 YuriiMobile. All rights reserved.
//

import UIKit

extension UITableViewCell: ReusableView, NibLoadableView {}

extension UITableView {
    
    func register<T: UITableViewCell>(_ : T.Type) {
        let cellNib = UINib(nibName: T.nibName, bundle: nil)
        register(cellNib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<Cell: UITableViewCell>(_ T: Cell.Type, forIndexPath indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? Cell else {
            fatalError("Could not dequeue cell with identifier: " + String(T.reuseIdentifier) + " or edit custom class to XIB file")
        }
        return cell
    }
    
}
