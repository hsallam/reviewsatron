//
//  ParsingTests.swift
//  reviewsatronTests
//
//  Created by Hobayier Sallam on 20.03.19.
//  Copyright © 2019 Hobs. All rights reserved.
//

import XCTest
@testable import reviewsatron

class ParsingTests: XCTestCase {

    var networkLink: MockNetworkLink!
    override func setUp() {
        networkLink = MockNetworkLink(maxConcurrentOperations: 1)
    }

    override func tearDown() {
    }

    func testReviewsParsing() {
        networkLink.request(to: RemoteResource.reviews(sortingPolicy: .date, page: 0, pageSize: 20)) { (result: Result<ReviewsResponse>) in
            switch result {
            case .success(let response):
                XCTAssert(response.data.count == 20)
            default:
                XCTFail("Couldn't load stub")
            }
        }
    }
}
