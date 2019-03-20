//
//  ReviewsResponse.swift
//  reviewsatron
//
//  Created by Hobayier Sallam on 19.03.19.
//  Copyright © 2019 Hobs. All rights reserved.
//

import UIKit

struct ReviewsResponse: Codable {
    let success: Bool
    let totalReviews: Int
    let data: [Review]
    private enum CodingKeys: String, CodingKey {
        case success = "status"
        case totalReviews = "total_reviews_comments"
        case data        
    }
}
