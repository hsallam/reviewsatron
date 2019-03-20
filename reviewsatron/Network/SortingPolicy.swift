//
//  SortingPolicy.swift
//  reviewsatron
//
//  Created by Hobayier Sallam on 19.03.19.
//  Copyright © 2019 Hobs. All rights reserved.
//

import Foundation

enum SortingPolicy {
    case rating
    case date
    
    var apiValue: String {
        switch self {
        case .rating:
            return "rating"
        case .date:
            return "date_of_review"
        }
    }
}
