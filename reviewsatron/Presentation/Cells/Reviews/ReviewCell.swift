//
//  ReviewCell.swift
//  reviewsatron
//
//  Created by Hobayier Sallam on 19.03.19.
//  Copyright © 2019 Hobs. All rights reserved.
//

import UIKit

protocol ReviewCell {
    func update(with review: Review)
}

typealias ReviewTableViewCell = UITableViewCell & ReviewCell
typealias ReviewCollectionViewCell = UICollectionViewCell & ReviewCell // To use if another modules needs to display reviews in a collection view
