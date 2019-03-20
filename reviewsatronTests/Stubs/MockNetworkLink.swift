//
//  MockNetworkLink.swift
//  reviewsatronTests
//
//  Created by Hobayier Sallam on 20.03.19.
//  Copyright © 2019 Hobs. All rights reserved.
//

import Foundation
@testable import reviewsatron

class StubError: Error {
    
}

class MockNetworkLink: NetworkLink {
    let queue: OperationQueue
    required init(maxConcurrentOperations: Int) {
        queue = OperationQueue()
        queue.name = "Network: (\(UUID().uuidString))"
        queue.maxConcurrentOperationCount = maxConcurrentOperations
    }
    
    @discardableResult
    func request<T>(to remoteResource: RemoteResource, completion: @escaping CompletionCallback<T>) -> URLSessionDataTask? {
        
        let stub = Stubs(remoteResource: remoteResource)
        
        if let data = stub.data {
            do {
                let parsedResponse = try JSONDecoder().decode(T.self, from: data)
                let result = Result.success(parsedResponse)
                completion(result)
            }
            catch let error {
                completion(.failure(error))
            }
        }
        else {
            completion(Result.failure(StubError()))
        }
        
        return nil
    }
    
    func cancelAll() {
        queue.operations.forEach { $0.cancel() }
    }
}
