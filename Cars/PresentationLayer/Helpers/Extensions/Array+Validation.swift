//
//  Array+Validation.swift
//  Cars
//
//  Created by Yurii on 11.09.2018.
//  Copyright © 2018 YuriiMobile. All rights reserved.
//

extension Array {
    
    func isValid(index: Int) -> Bool {
        return index >= startIndex && index < endIndex
    }
    
}
