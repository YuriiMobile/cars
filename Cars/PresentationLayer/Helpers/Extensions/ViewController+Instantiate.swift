//
//  ViewController+Instantiate.swift
//  Cars
//
//  Created by Yurii on 13.09.2018.
//  Copyright © 2018 YuriiMobile. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func instantiate<T: Storyboardable>() -> T  {
        let storyboard = UIStoryboard(name: T.storyboardName, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: T.identifier) as? T else {
            fatalError("Cannot instantiate view controller at identifier \(T.identifier)")
        }
        
        return viewController
    }
    
}
