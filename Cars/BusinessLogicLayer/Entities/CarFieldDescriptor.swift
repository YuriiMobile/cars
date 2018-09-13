//
//  CarFieldDescriptor.swift
//  Cars
//
//  Created by Yurii on 11.09.2018.
//  Copyright © 2018 YuriiMobile. All rights reserved.
//

struct CarFieldDescriptor {
    
    let fieldType: Car.CodingKeys
    let header: String
    let value: String
    
    init(fieldType: Car.CodingKeys, value: String) {
        self.fieldType = fieldType
        self.value = value
        self.header = "\(fieldType.rawValue.uppercasedFirst()):"
    }
    
}
