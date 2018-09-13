//
//  Reusable.swift
//  Cars
//
//  Created by Yurii on 11.09.2018.
//  Copyright © 2018 YuriiMobile. All rights reserved.
//

import UIKit

protocol NibLoadableView: class {}

extension NibLoadableView where Self: UIView
{
    static var nibName: String {
        return String(describing: self)
    }
}

protocol ReusableView {}

extension ReusableView where Self: UIView
{
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
