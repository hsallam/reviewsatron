//
//  ReviewsPresenter.swift
//  reviewsatron
//
//  Created by Hobayier Sallam on 19.03.19.
//  Copyright © 2019 Hobs. All rights reserved.
//

import Foundation

protocol ReviewsPresenterInput {
    func viewDidAppear()
    func viewScrolledToLoadMoreZone()
}

protocol ReviewsPresenterOutput: class {
    func append(reviews: [Review], atIndexPaths indexPaths: [IndexPath])
    func noMoreItemsToLoad()
    func showEmptyView()
}

class ReviewsPresenter {
    weak var view: ReviewsPresenterOutput?
    var interactor: ReviewsInteractorInput!
    var router: ReviewsRouter!
    
    fileprivate var currentPage: Int = -1 // API is zero-based
    fileprivate let pageSize = 20
    fileprivate var totalReviews: Int = 0
    fileprivate var loadingItemsInProgress = false
}

extension ReviewsPresenter: ReviewsPresenterInput {
    func viewScrolledToLoadMoreZone() {
        loadMoreReviews()
    }
    
    func viewDidAppear() {
        loadMoreReviews()
    }
    
    func loadMoreReviews() {
        guard (currentPage * pageSize) <= totalReviews else {
            if currentPage != 0 && !loadingItemsInProgress {
                view?.noMoreItemsToLoad()
            }
            return
        }
        
        guard  loadingItemsInProgress == false else { return }
        
        loadingItemsInProgress = true
        interactor.loadReviews(page: currentPage + 1, pageSize: pageSize)
    }
}

extension ReviewsPresenter: ReviewsInteractorOutput {
    func loaded(reviews: [Review], page: Int, totalReviews: Int) {        
        let currentItemCount = currentPage * pageSize
        let newItemCount = page * pageSize
        let indexPaths = (currentItemCount..<newItemCount).map{IndexPath(row: $0, section: 0)}
        self.currentPage = page
        self.totalReviews = totalReviews
        view?.append(reviews: reviews, atIndexPaths: indexPaths)
        self.loadingItemsInProgress = false
    }
    
    func failedToLoadItems() {
        let currentItemCount = currentPage * pageSize
        if currentItemCount > 0 {
            view?.noMoreItemsToLoad()
        }
        else {
            view?.showEmptyView()
        }
    }
}
