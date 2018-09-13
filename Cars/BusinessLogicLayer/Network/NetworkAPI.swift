//
//  NetworkAPI.swift
//  Cars
//
//  Created by Yurii on 11.09.2018.
//  Copyright © 2018 YuriiMobile. All rights reserved.
//

import Foundation
import PromiseKit

enum NetworkFetchError: Error {
    
    case fileNotFound
    case undexpectedResult
    
}

protocol CarsGateway: class {
    
    func fetchAll() -> Promise<[Car]>
    func fetchCars(withOffset offset: Int, limit: Int) -> Promise<[Car]>
    
}

class NetworkAPI: CarsGateway {

    // To simulate pagination need to store all data from .json
    private lazy var items: [Car] = []
    private let networkQueue: DispatchQueue = DispatchQueue(label: "com.yuriimobile.cars.network")
    private let decoder: JSONDecoder
    
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    
    func fetchAll() -> Promise<[Car]> {
        return fileData()
    }
    
    func fetchCars(withOffset offset: Int, limit: Int) -> Promise<[Car]> {
        return after(seconds: 1).then {
            self.fileData()
        }.map(on: .main) { _ in
            self.fetchLocal(with: offset, limit: limit)
        }
    }
    
    private func fileData() -> Promise<[Car]> {
        guard items.isEmpty else {
            return Promise.value(items)
        }
        
        return networkQueue.async(.promise) {
            guard let dataUrl = Bundle.main.url(forResource: "locations", withExtension: "json") else {
                throw NetworkFetchError.fileNotFound
            }
            let data = try Data(contentsOf: dataUrl)
            let placemarks = try self.decoder.decode(Placemarks.self, from: data)
            
            // Store all items to use it for pagination later
            self.items = placemarks.items
            
            return placemarks.items
        }
        
    }
    
    private func fetchLocal(with offset: Int, limit: Int) -> [Car] {
        let startIndex = offset
        let endIndex = min(offset + limit, items.count)
        return Array(items[startIndex..<endIndex])
    }
    
}
