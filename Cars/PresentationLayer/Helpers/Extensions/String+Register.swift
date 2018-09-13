//
//  String+Register.swift
//  Cars
//
//  Created by Yurii on 13.09.2018.
//  Copyright © 2018 YuriiMobile. All rights reserved.
//

extension String {
    
    func uppercasedFirst() -> String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
    
}
