//
//  CarListPresenterImp.swift
//  Cars
//
//  Created by Yurii on 11.09.2018.
//  Copyright © 2018 YuriiMobile. All rights reserved.
//

import UIKit
import PromiseKit

typealias InsertIndexes = (startIndex: Int, endIndex: Int)

class CarListPresenterImp: CarListPresenter {

    private var carsList: [Car]
    private let carsService: CarsService
    private let fetchHelper: FetchHelper
    private let fetchDistance: Int = 3
    private(set) weak var carsListView: CarsListView?
    private(set) weak var paginationDelegate: CarsPaginationDelegate?
    
    var isLastPage: Bool {
        return fetchHelper.isLastPage
    }
    var carsCount: Int {
        return carsList.count
    }

    init(carsService: CarsService = CarsService(),
         fetchHelper: FetchHelper = FetchHelper(),
         carsListView: CarsListView? = nil,
         paginationDelegate: CarsPaginationDelegate? = nil,
         carsList: [Car] = []) {
        self.carsService = carsService
        self.fetchHelper = fetchHelper
        self.carsListView = carsListView
        self.paginationDelegate = paginationDelegate
        self.carsList = carsList
    }
    
    func viewDidLoad() {
        firstly {
            initialFetching()
        }.done { _ in
            self.carsListView?.reloadData()
        }.catch { error in
            self.paginationDelegate?.carPresenter(self, didUpdateFetchState: .fail(error))
        }
    }
    
    func carName(at index: Int) -> String {
        return car(at: index)?.name ?? "undefined"
    }
    
    func car(at index: Int) -> Car? {
        guard carsList.isValid(index: index) else {
            return nil
        }
        
        return carsList[index]
    }
    
}

extension CarListPresenterImp {
    
    private func initialFetching() -> Promise<Void> {
        return fetchData().asVoid()
    }
    
    func attemptFetchNextPage(currentRowIndex: Int) {
        guard !fetchHelper.isFetching, !fetchHelper.isLastPage, currentRowIndex >= carsCount - fetchDistance else {
            return
        }
        
        firstly {
            fetchData()
        }.done { indexes in
            self.carsListView?.insertCells(at: indexes)
        }.catch { error in
            self.paginationDelegate?.carPresenter(self, didUpdateFetchState: .fail(error))
        }
    }
    
    private func fetchData() -> Promise<InsertIndexes?> {
        willStartFetching()
        return firstly {
            carsService.fetchCars(withOffset: fetchHelper.offset, limit: fetchHelper.limit)
        }.map { cars -> InsertIndexes? in
            self.willEndFetching(resultCount: cars.count)
            
            guard !cars.isEmpty else {
                return nil
            }
            
            self.carsList.append(contentsOf: cars)
            return (startIndex: self.fetchHelper.oldOffset,
                    endIndex: self.fetchHelper.offset - 1)
        }
    }
    
    private func willStartFetching() {
        fetchHelper.startFetching()
        paginationDelegate?.carPresenter(self, didUpdateFetchState: fetchHelper.state)
    }
    
    private func willEndFetching(resultCount: Int) {
        fetchHelper.endFetching(resultsCount: resultCount)
        paginationDelegate?.carPresenter(self, didUpdateFetchState: fetchHelper.state)
    }
    
}
