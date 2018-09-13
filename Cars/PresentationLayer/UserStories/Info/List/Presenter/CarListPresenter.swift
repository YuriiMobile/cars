//
//  CarListPresenter.swift
//  Cars
//
//  Created by Yurii on 11.09.2018.
//  Copyright © 2018 YuriiMobile. All rights reserved.
//

import PromiseKit

protocol CarListPresenter: class {
    
    var carsListView: CarsListView? { get }
    var paginationDelegate: CarsPaginationDelegate? { get }
    var isLastPage: Bool { get }
    var carsCount: Int { get }
    
    func viewDidLoad()
    func attemptFetchNextPage(currentRowIndex: Int)
    func carName(at index: Int) -> String
    func car(at index: Int) -> Car?
    
}

protocol CarsPaginationDelegate: class {
    
    func carPresenter(_ carPresenter: CarListPresenter, didUpdateFetchState state: FetchState)
    
}
