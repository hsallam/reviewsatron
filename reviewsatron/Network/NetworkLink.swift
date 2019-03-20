//
//  NetworkLink.swift
//  reviewsatron
//
//  Created by Hobayier Sallam on 19.03.19.
//  Copyright © 2019 Hobs. All rights reserved.
//

import Foundation

enum Result<T: NetworkResponse> {
    case success(T)
    case failure(Error)
}

typealias CompletionCallback<T: NetworkResponse> = (Result<T>)->()
typealias NetworkResponse = Codable

class NetworkOperation<T: NetworkResponse>: Operation {
    
    var dataTask: URLSessionDataTask?
    
    private let remoteResource: RemoteResource
    private let completion: CompletionCallback<T>
    init(_ remoteResource: RemoteResource, completion: @escaping CompletionCallback<T>) {
        self.remoteResource = remoteResource
        self.completion = completion
    }
    
    override func main() {
        if isCancelled {
            return
        }
        
        guard let urlRequest = remoteResource.urlRequest else { return }
        
        dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                self.completion(.failure(error))
            }
            else if let data = data {
                do {
                    let parsedResponse = try JSONDecoder().decode(T.self, from: data)
                    let result = Result.success(parsedResponse)
                    self.completion(result)
                }
                catch let error {
                    self.completion(.failure(error))
                }
            }
        }
        
        dataTask?.resume()
    }
    
    override func cancel() {
        dataTask?.cancel()
    }
}

protocol NetworkLink {
    var queue: OperationQueue { get }
    init(maxConcurrentOperations: Int)
    @discardableResult func request<T>(to remoteResource: RemoteResource, completion: @escaping CompletionCallback<T>) -> URLSessionDataTask?
}

class DefaultNetworkLink: NetworkLink {
    
    let queue: OperationQueue
    required init(maxConcurrentOperations: Int) {
        queue = OperationQueue()
        queue.name = "Network: (\(UUID().uuidString))"
        queue.maxConcurrentOperationCount = maxConcurrentOperations
    }
    
    @discardableResult
    func request<T>(to remoteResource: RemoteResource, completion: @escaping CompletionCallback<T>) -> URLSessionDataTask? {
        let operation = NetworkOperation(remoteResource, completion: completion)
        queue.addOperation(operation)
        return operation.dataTask
    }        
    
    func cancelAll() {
        queue.operations.forEach { $0.cancel() }
    }
}
