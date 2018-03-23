//
//  Mocks.swift
//  ElementsInteractiveTests
//
//  Created by Shabir Jan on 3/12/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import UIKit
@testable import ElementsInteractive

//The mocks here are not required for the test so we only need them to satisfy the compilerclass
class MockNetwork: Network {
    func makeRequest(request: NetworkRequest, success: @escaping (Data) -> Void, failure: @escaping (Error) -> Void) -> NetworkCancelable? {return nil}
    
   
}
class MockImageCache: ImageCache {
    convenience init() { self.init(network: MockNetwork()) }
    required init(network: Network) { }
    func image(url: String, success: @escaping (UIImage) -> Void, failure: @escaping (Error) -> Void) -> NetworkCancelable? { return nil }
    func hasImageFor(url: String) -> Bool { return false }
    func cachedImage(url: String, or: UIImage?) -> UIImage? { return nil }
    func clearCache() { }
}
