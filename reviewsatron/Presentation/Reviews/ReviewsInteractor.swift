//
//  ReviewsInteractor.swift
//  reviewsatron
//
//  Created by Hobayier Sallam on 19.03.19.
//  Copyright © 2019 Hobs. All rights reserved.
//

import Foundation

protocol ReviewsInteractorInput {
    func loadReviews(page: Int, pageSize:Int)
}

protocol ReviewsInteractorOutput: class {
    func loaded(reviews: [Review], page: Int, totalReviews: Int)
    func failedToLoadItems()
}

class ReviewsInteractor {
    weak var output: ReviewsInteractorOutput?
    
    let networkLink: NetworkLink
    
    init(networkLink: NetworkLink) {
        self.networkLink = networkLink
    }
}

extension ReviewsInteractor: ReviewsInteractorInput {
    func loadReviews(page: Int, pageSize:Int) {
        networkLink.request(to: .reviews(sortingPolicy: .date, page: page, pageSize: pageSize)) { [weak self] (result: Result<ReviewsResponse>) in
            switch result {
            case .success(let response):
                if response.success {
                    self?.output?.loaded(reviews: response.data, page: page, totalReviews: response.totalReviews)
                }
                else {
                    self?.output?.failedToLoadItems()
                }
            case .failure(_):
                self?.output?.failedToLoadItems()
            }
        }
    }
}
