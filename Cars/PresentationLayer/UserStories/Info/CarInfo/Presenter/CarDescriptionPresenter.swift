//
//  CarDescriptionPresenter.swift
//  Cars
//
//  Created by Yurii on 11.09.2018.
//  Copyright © 2018 YuriiMobile. All rights reserved.
//

protocol CarDescriptionPresenter: class {
    
    var fieldCount: Int { get }
    
    func description(at index: Int) -> CarFieldDescriptor?
    
}
