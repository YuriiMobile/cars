//
//  ConfigurableCell.swift
//  Cars
//
//  Created by Yurii on 12.09.2018.
//  Copyright © 2018 YuriiMobile. All rights reserved.
//

protocol ConfigurableCell: class {
    
    associatedtype Item
    func configure(with item: Item)
    
}
