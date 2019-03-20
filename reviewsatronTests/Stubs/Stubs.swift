//
//  Stubs.swift
//  reviewsatronTests
//
//  Created by Hobayier Sallam on 20.03.19.
//  Copyright © 2019 Hobs. All rights reserved.
//

import Foundation
@testable import reviewsatron

enum Stubs: String {
    case reviews = "reviews"
    
    var type: String {
        switch self {
        case .reviews:
            return "json"
        }
    }
    
    init(remoteResource: RemoteResource) {
        switch remoteResource {
        case .reviews:
            self = .reviews
        }
    }
    
    var data: Data? {
        guard let path = Bundle(for: MockNetworkLink.self).url(forResource: self.rawValue, withExtension: type) else { return nil }
        return try? Data(contentsOf: path)
    }
    
}
