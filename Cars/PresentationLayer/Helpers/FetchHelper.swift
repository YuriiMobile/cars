//
//  FetchHelper.swift
//  Cars
//
//  Created by Yurii on 11.09.2018.
//  Copyright © 2018 YuriiMobile. All rights reserved.
//

enum FetchState: Equatable {
    case scrolling
    case fetching
    case fail(Error)
}

func == (lhs: FetchState, rhs: FetchState) -> Bool {
    switch (lhs, rhs) {
    case (.scrolling, .scrolling):
        return true
    case (.fetching, .fetching):
        return true
    case (.fail(_), .fail(_)):
        return true
    default:
        return false
    }
}

class FetchHelper {
    
    let limit: Int
    private(set) var offset: Int = 0
    private(set) var oldOffset: Int = 0
    private(set) var isLastPage: Bool = false
    private(set) var state: FetchState = .scrolling
    
    var isFetching: Bool {
        return state == .fetching
    }
    
    init(limit: Int = 50) {
        self.limit = limit
    }
    
    func startFetching() {
        state = .fetching
    }
    
    func endFetching(resultsCount: Int) {
        isLastPage = resultsCount < limit
        oldOffset = offset
        offset += resultsCount
        
        state = .scrolling
    }
    
}
