//
//  ImageCache.swift
//  DemoApp
//
//  Created by Shabir Jan on 3/11/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import UIKit
enum ImageCacheError: Error, LocalizedError {

    case invalidResponse

    public var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return NSLocalizedString("Recevied an Invalid response", comment: "my error")
        }
    }
}

protocol ImageCache {
    init(network: Network)
    func image(at url: String, callback: @escaping (ImageCacheProviderResult<UIImage>) -> Void)  -> NetworkCancelable?
    func hasImageFor(url: String) -> Bool
    func cachedImage(url: String, or: UIImage?) -> UIImage?
    func clearCache()
}
