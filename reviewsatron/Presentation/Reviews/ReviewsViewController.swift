//
//  ReviewsViewController.swift
//  reviewsatron
//
//  Created by Hobayier Sallam on 19.03.19.
//  Copyright © 2019 Hobs. All rights reserved.
//

import UIKit

class ReviewsViewController: UIViewController {
    var presenter: ReviewsPresenterInput!
    var dataSource: ReviewsTableViewDataSource! {
        didSet {
            dataSource.delegate = self
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = NSLocalizedString("Reviewsatron", comment: "")
        tableView.register(UINib(nibName: "BasicReviewTableViewCell", bundle: nil) , forCellReuseIdentifier: dataSource.cellIdentifier)
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.tableFooterView = UIView(frame: .zero)
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .always
        }
        presenter.viewDidAppear()
    }
}


extension ReviewsViewController: ReviewsPresenterOutput {
    func append(reviews: [Review], atIndexPaths indexPaths: [IndexPath]) {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
            self.dataSource.append(reviews: reviews)
            self.tableView.reloadData()
        }
    }
    
    func noMoreItemsToLoad() {
        dataSource.hasMoreItemsToLoad = false
    }
    
    func showEmptyView() {
        dataSource.hasMoreItemsToLoad = false
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
            let messageLabel = UILabel(frame: self.view.bounds)
            messageLabel.text = NSLocalizedString("🏜\nTough luck, kid!\nNothing to show here!", comment: "")
            messageLabel.numberOfLines = 0;
            messageLabel.textAlignment = .center;
            messageLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            messageLabel.backgroundColor = .white
            messageLabel.font = UIFont.systemFont(ofSize: 20)

            self.view.addSubview(messageLabel)
        }
    }
}

extension ReviewsViewController: ReviewsTableViewDataSourceDelegate {
    func tableReachedLoadMoreZone() {
        presenter.viewScrolledToLoadMoreZone()
    }
}
