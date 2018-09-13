//
//  FetchHelperTests.swift
//  CarsTests
//
//  Created by Yurii on 11.09.2018.
//  Copyright © 2018 YuriiMobile. All rights reserved.
//

import XCTest
@testable import Cars

class FetchHelperTests: XCTestCase {
    
    private var fetchHelper: FetchHelper!
    
    override func setUp() {
        super.setUp()
        
        fetchHelper = FetchHelper()
    }
    
    func testFetchState() {
        fetchHelper.startFetching()
        
        XCTAssertTrue(fetchHelper.isFetching)
    }
    
    func testEndFetchingNotLastPage() {
        let resultsCount = 50
        fetchHelper.startFetching()
        fetchHelper.endFetching(resultsCount: resultsCount)
        
        XCTAssertFalse(fetchHelper.isLastPage)
        XCTAssertFalse(fetchHelper.isFetching)
        XCTAssertTrue(fetchHelper.offset == resultsCount, "Actual offset = \(fetchHelper.offset)")
        XCTAssertTrue(fetchHelper.oldOffset == 0, "Actual old offset = \(fetchHelper.oldOffset)")
    }
    
    func testEndFetchingLastPage() {
        let firstResultsCount = 50
        fetchHelper.startFetching()
        fetchHelper.endFetching(resultsCount: firstResultsCount)
        
        let secondResultsCount = 10
        fetchHelper.startFetching()
        fetchHelper.endFetching(resultsCount: secondResultsCount)
        
        XCTAssertTrue(fetchHelper.isLastPage)
        XCTAssertFalse(fetchHelper.isFetching)
        XCTAssertTrue(fetchHelper.offset == firstResultsCount + secondResultsCount, "Actual offset = \(fetchHelper.offset)")
        XCTAssertTrue(fetchHelper.oldOffset == firstResultsCount, "Actual old offset = \(fetchHelper.oldOffset)")
    }
    
}
