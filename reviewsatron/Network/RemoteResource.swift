//
//  RemoteResource.swift
//  reviewsatron
//
//  Created by Hobayier Sallam on 19.03.19.
//  Copyright © 2019 Hobs. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

enum RemoteResource {
    case reviews(sortingPolicy: SortingPolicy, page: Int, pageSize: Int)
    
    var baseUrl: String {
        switch self {
        case .reviews:
            return BaseUrl.getYourGuide.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .reviews:
            return "berlin-l17/tempelhof-2-hour-airport-history-tour-berlin-airlift-more-t23776/reviews.json"
        }
    }
    
    var method: String {
        switch self {
        case .reviews:
            return HTTPMethod.GET.rawValue
        }
    }
    
    var queryItems: [URLQueryItem] {
        // (1) Construct the default items for all endpoints
        var queryItems: [URLQueryItem] = []
        
        // (2) Add endpoint-specific items.
        switch self {
        case .reviews(let sortingPolicy, let page, let pageSize):
            queryItems.append(URLQueryItem(name: "sortBy", value: sortingPolicy.apiValue))
            queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
            queryItems.append(URLQueryItem(name: "count", value: "\(pageSize)"))
        }
        return queryItems
    }
    
    var urlRequest: URLRequest? {
        return URLRequest(remoteResource: self)
    }
}

extension URLRequest {
    init(remoteResource: RemoteResource) {
        var urlString = remoteResource.baseUrl
        var path = remoteResource.path
        if path.first == "/" {
            path.removeFirst()
        }
        urlString = urlString.last == "/" ? urlString : urlString + "/"
        urlString += path
        
        guard var urlComponents = URLComponents(string: urlString) else {
            fatalError("☠️ \(remoteResource.baseUrl) is malformed")
        }
        
        urlComponents.queryItems = remoteResource.queryItems
        
        guard let url = urlComponents.url else {
            fatalError("☠️ \(urlComponents) is malformed")
        }

        self.init(url: url)
        self.httpMethod = remoteResource.method
    }
}
