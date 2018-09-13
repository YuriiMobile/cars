//
//  CarDescriptionTableViewCell.swift
//  Cars
//
//  Created by Yurii on 11.09.2018.
//  Copyright © 2018 YuriiMobile. All rights reserved.
//

import UIKit

class CarDescriptionTableViewCell: UITableViewCell, ConfigurableCell {

    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    func configure(with item: CarFieldDescriptor) {
        headerLabel.text = item.header
        descriptionLabel.text = item.value
    }

}
