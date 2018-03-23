//
//  NetworkProvider.swift
//  DemoApp
//
//  Created by Shabir Jan on 3/11/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import Foundation

class NetworkProvider: Network {
    
    // MARK: - Private
    let session: URLSession
    
    // MARK: - Lifecycle
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    // MARK: - Public
    public func makeRequest(request: NetworkRequest, callback: @escaping (NetworkResult<Data>) -> Void) -> NetworkCancelable? {
        do {
            let request = try request.buildURLRequest()
            let task = self.session.dataTask(with: request) { (data, _, error) in
                guard let data = data else {
                    DispatchQueue.main.async {
                        callback(.error(error ?? NetworkError.unknown))
                    }
                    return
                }
                callback(.success(data))
            }
            task.resume()
            return task
        } catch let error {
            callback(.error(error))
            return nil
        }
    }
}
