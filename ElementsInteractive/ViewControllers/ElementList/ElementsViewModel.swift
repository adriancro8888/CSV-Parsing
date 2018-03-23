//
//  ElementsViewModel.swift
//  DemoApp
//
//  Created by Shabir Jan on 3/11/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import Foundation
class ElementsViewModel {

    // MARK: - Private
    private let api: API
    private let imageCache: ImageCache
    private let fileService: FileService

    // MARK: - Lifeycle
    init(api: API, imageCache: ImageCache, fileService: FileService) {
        self.api = api
        self.imageCache = imageCache
        self.fileService = fileService
    }

    // MARK: - Events
    var didError: ((Error) -> Void)?
    var didUpdate: ((ElementsViewModel) -> Void)?
    var didSelectElement: ((Element) -> Void)?

    // MARK: - Properties
    let elementViewModelsTypes: [CellRepresentable.Type] = [ElementCellViewModel.self]
    private(set) var elementViewModels = [CellRepresentable]()
    var title: String {
        return self.isUpdating ? "Refreshing..." : "Elements Interactive"
    }
    private(set) var isUpdating: Bool = false {
        didSet { self.didUpdate?(self) }
    }

    // MARK: - Actions
    func reloadData() {
        self.isUpdating = true
        self.api.getItems(success: { [weak self] (elements) in
            guard let strongSelf = self else { return }
            if elements.count > 0 {
            strongSelf.elementViewModels = elements.map {strongSelf.viewModelFor(element: $0)}
            } else {
                strongSelf.didError?(APIError.noItems)
            }
            strongSelf.isUpdating = false
            }, failure: { [weak self] error in
                guard let strongSelf = self else { return }

                strongSelf.didError?(error)
                strongSelf.isUpdating = false
        })
    }

    // MARK: - Helpers
    private func viewModelFor(element: Element) -> CellRepresentable {
        let viewModel = ElementCellViewModel(element: element, imageCache: self.imageCache)
        viewModel.didSelectElement = {[weak self] element in
            self?.didSelectElement?(element)
        }

        viewModel.didError = { [weak self] error in
            self?.didError?(error)
        }
        return viewModel
    }
}
