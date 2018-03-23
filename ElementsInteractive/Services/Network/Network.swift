//
//  Network.swift
//  DemoApp
//
//  Created by Shabir Jan on 3/11/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import Foundation
enum NetworkResult<T> {
    case success(Data)
    case error(Error)
}
enum NetworkError: Error, LocalizedError {
    case unknown
    case invalidResponse
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return NSLocalizedString("An unknown error occured", comment: "My error")
        case .invalidResponse:
            return NSLocalizedString("Recevied an Invalid response", comment: "my error")
        }
    }
}

protocol NetworkCancelable {
    func cancel()
}

extension URLSessionDataTask: NetworkCancelable { }

protocol Network {
    func makeRequest(request: NetworkRequest, callback: @escaping (NetworkResult<Data>) -> Void) -> NetworkCancelable?
}
