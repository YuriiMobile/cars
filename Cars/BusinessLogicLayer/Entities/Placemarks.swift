//
//  Placemarks.swift
//  Cars
//
//  Created by Yurii on 11.09.2018.
//  Copyright © 2018 YuriiMobile. All rights reserved.
//

struct Placemarks: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case items = "placemarks"
    }
    
    let items: [Car]
    
}

