//
//  ReviewsModule.swift
//  reviewsatron
//
//  Created by Hobayier Sallam on 19.03.19.
//  Copyright © 2019 Hobs. All rights reserved.
//

import UIKit

struct ReviewsModuleDependencies: Dependencies {
    let networkLink: NetworkLink
}

class ReviewsModule: Module {
    typealias Dependencies = ReviewsModuleDependencies
    static func assemble(dependencies: ReviewsModuleDependencies) -> UIViewController {
        let view = ReviewsViewController(nibName: "ReviewsViewController", bundle: nil)
        
        let presenter = ReviewsPresenter()
        let interactor = ReviewsInteractor(networkLink: dependencies.networkLink)
        let router = ReviewsRouter()
        let dataSource = ReviewsTableViewDataSource()
        
        view.presenter = presenter
        view.dataSource = dataSource
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        
        router.viewController = view
        
        return view
    }
}
