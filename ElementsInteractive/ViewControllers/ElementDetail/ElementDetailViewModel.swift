//
//  ElementDetailViewModel.swift
//  DemoApp
//
//  Created by Shabir Jan on 3/11/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import UIKit

class  ElementDetailViewModel {
    // MARK: - Private
    private let element: Element
    private let imageCache: ImageCache
    private var imageCacheCancellable: NetworkCancelable?

    // MARK: - Lifecycle
    init(element: Element, imageCache: ImageCache) {
        self.element = element
        self.imageCache = imageCache
        self.loadLargeImage()
    }
    deinit {
        self.imageCacheCancellable?.cancel()
    }

    // MARK: - Events
    var didError: ((Error) -> Void)?
    var didUpdate: (() -> Void)?

    // MARK: - Properties
    var title: String { return self.element.title }
    private(set) lazy var image: UIImage? = {
        guard let url = self.element.photoURL else {
            return nil
        }
        return self.imageCache.cachedImage(
            url: url,
            or: UIImage(named: "default"))
    }()
    var desc: String { return self.element.description }

    // MARK: - Actions
    private func loadLargeImage() {

        guard let url = self.element.photoURL else {return }

        if self.imageCache.hasImageFor(url: url) { return }
        self.imageCacheCancellable = self.imageCache.image(at: url, callback: { [weak self] result in
            switch result {
            case .success(let image):
                guard let strongSelf = self else { return }
                strongSelf.image = image
                strongSelf.didUpdate?()
            case .error( _):
                print("")
            }
        })
    }
}
