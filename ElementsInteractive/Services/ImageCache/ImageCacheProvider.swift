//
//  ImageCacheProvider.swift
//  DemoApp
//
//  Created by Shabir Jan on 3/11/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import UIKit

enum ImageCacheProviderResult<T> {
    case success(T)
    case error(ImageCacheError)
}

class ImageCacheProvider: ImageCache {
    // MARK: - Private
    private var cache = [String: UIImage]()
    private let network: Network
    // MARK: - Lifecycle
    required init(network: Network) {
        self.network = network
    }
    // MARK: - Public
    func image(at url: String, callback: @escaping (ImageCacheProviderResult<UIImage>) -> Void) -> NetworkCancelable? {
        if let existing = cache[url] {
            callback(.success(existing))
            return nil
        }
        let request = NetworkRequest(method: .get, url: url)
        return network.makeRequest(request: request, callback: { [weak self] result in
            
            switch result {
            case .success(let data):
                guard let strongSelf = self else { return }
                guard let image = UIImage(data: data) else {
                    callback(.error(ImageCacheError.invalidResponse))
                    return
                }
                strongSelf.cache[url] = image
                DispatchQueue.main.async {
                    callback(.success(image))
                }
            case .error( _):
                callback(.error(ImageCacheError.invalidResponse))
            }
        })
    }
    func hasImageFor(url: String) -> Bool {
        return (self.cache[url] != nil)
    }
    func cachedImage(url: String, or: UIImage?) -> UIImage? {
        return self.cache[url] ?? or
    }
    func clearCache() {
        cache = [String: UIImage]()
    }
}
