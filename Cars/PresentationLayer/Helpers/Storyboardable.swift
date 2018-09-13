//
//  Storyboardable.swift
//  Cars
//
//  Created by Yurii on 12.09.2018.
//  Copyright © 2018 YuriiMobile. All rights reserved.
//

protocol Storyboardable: class {
    
    static var storyboardName: String { get }
    static var identifier: String { get }
    
}

extension Storyboardable {
    
    static var identifier: String {
        return String(describing: Self.self)
    }
    
}
