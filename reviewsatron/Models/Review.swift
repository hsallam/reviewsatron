//
//  Review.swift
//  reviewsatron
//
//  Created by Hobayier Sallam on 19.03.19.
//  Copyright © 2019 Hobs. All rights reserved.
//

import UIKit

// Probably an incomplete list and might cause a parsing error if an unexpected value was encountered, but I don't have the documentation of the API to anticipate that.
enum TravellerType: String, Codable {
    case friends = "friends"
    case oldFamily = "family_old"
    case youngFamily = "family_young"
    case solo = "solo"
    case couple = "couple"
}

struct Review: Codable {
    let id: Int
    let title: String?
    let rating: String
    let message: String
    let author: String
    let languageCode: String
    let travellerType: TravellerType?
    let reviewerName: String
    let country: String
    let reviewerInitials: String
    let reviewerProfilePhoto: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "review_id"
        case title
        case rating
        case message
        case author
        case languageCode
        case travellerType = "traveler_type"
        case reviewerName
        case country = "reviewerCountry"
        case reviewerInitials = "firstInitial"
        case reviewerProfilePhoto
    }
}
