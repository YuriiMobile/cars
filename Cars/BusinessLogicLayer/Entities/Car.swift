//
//  Car.swift
//  Cars
//
//  Created by Yurii on 11.09.2018.
//  Copyright © 2018 YuriiMobile. All rights reserved.
//

import UIKit

enum EngineType: String, Codable {
    
    case ce = "CE"
    
}

enum AppearanceLevel: String, Codable {
    
    case unacceptable = "UNACCEPTABLE"
    case good = "GOOD"
    
}

struct Car: Decodable {

    enum CodingKeys: String, CodingKey {
        case vin
        case name
        case address
        case coordinates
        case engineType
        case exteriorLevel = "exterior"
        case interiorLevel = "interior"
        case fuel
    }
    
    let vin: String?
    let name: String?
    let address: String?
    let coordinates: CGPoint?
    let engineType: EngineType?
    let exteriorLevel: AppearanceLevel?
    let interiorLevel: AppearanceLevel?
    let fuel: Int?
    
    init(vin: String,
         name: String,
         address: String? = nil,
         coordinates: CGPoint? = nil,
         engineType: EngineType? = nil,
         exteriorLevel: AppearanceLevel? = nil,
         interiorLevel: AppearanceLevel? = nil,
         fuel: Int? = nil) {
        self.vin = vin
        self.name = name
        self.address = address
        self.coordinates = coordinates
        self.engineType = engineType
        self.exteriorLevel = exteriorLevel
        self.interiorLevel = interiorLevel
        self.fuel = fuel
    }
        
}
