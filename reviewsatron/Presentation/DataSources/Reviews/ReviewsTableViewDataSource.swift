//
//  ReviewsDataSource.swift
//  reviewsatron
//
//  Created by Hobayier Sallam on 19.03.19.
//  Copyright © 2019 Hobs. All rights reserved.
//

import UIKit

protocol ReviewsTableViewDataSourceDelegate: class {
    func tableReachedLoadMoreZone()
}

class ReviewsTableViewDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    fileprivate var reviews = [Review]()
    let cellIdentifier = "reviewCell"
    fileprivate let estimatedCellHeight: CGFloat = 120.0
    fileprivate var cellHeights: [IndexPath : CGFloat] = [:]
    weak var delegate: ReviewsTableViewDataSourceDelegate?
    var hasMoreItemsToLoad = true
    
    func append(reviews: [Review]) {
        self.reviews.append(contentsOf: reviews)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ReviewTableViewCell else {
            fatalError("☠️ Couldn't dequeue cell. Sure you used a cell conforming to ReviewTableViewCell?")
        }
        
        let review = reviews[indexPath.row]
        cell.update(with: review)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeights[indexPath] = cell.frame.size.height
        
        // Show indicator for loading more.
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            if hasMoreItemsToLoad {
                let spinner = UIActivityIndicatorView(style: .gray)
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
                
                tableView.tableFooterView = spinner
                tableView.tableFooterView?.isHidden = false
            }
            else {
                tableView.tableFooterView =  UIView(frame: .zero)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath] ?? UITableView.automaticDimension
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let bottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height
        let buffer: CGFloat = 2.0 * estimatedCellHeight
        let scrollPosition = scrollView.contentOffset.y
        
        if scrollPosition > bottom - buffer {
            delegate?.tableReachedLoadMoreZone()
        }
    }
}
