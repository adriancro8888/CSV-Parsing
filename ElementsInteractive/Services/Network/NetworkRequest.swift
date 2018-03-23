//
//  NetworkRequest.swift
//  DemoApp
//
//  Created by Shabir Jan on 3/11/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import Foundation

enum NetworkRequestError: Error, LocalizedError {
    case invalidURL(String)
    public var errorDescription: String? {
        switch self {
        case .invalidURL(let url):
            return NSLocalizedString("The url '\(url)' was invalid", comment: "My error")
        }
    }
}

struct NetworkRequest {
    // MARK: - HTTP Methods
    enum Method: String {
        case get        = "GET"
        case put        = "PUT"
        case patch      = "PATCH"
        case post       = "POST"
        case delete     = "DELETE"
    }

    // MARK: - Public Properties
    let method: NetworkRequest.Method
    let url: String

    // MARK: - Public Functions
    func buildURLRequest() throws -> URLRequest {
        guard let url = URL(string: self.url) else { throw NetworkRequestError.invalidURL(self.url) }

        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue

        return request
    }
}
