//
//  ElementCellViewModel.swift
//  DemoApp
//
//  Created by Shabir Jan on 3/11/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import UIKit
class ElementCellViewModel {

    // MARK: - Private
    private let element: Element
    private let imageCache: ImageCache
    private var imageCacheCancellable: NetworkCancelable?

    // MARK: - Lifecycle
    init(element: Element, imageCache: ImageCache) {
        self.element = element
        self.imageCache = imageCache
    }
    deinit {
        self.imageCacheCancellable?.cancel()
    }

    // MARK: - Events
    var didError: ((Error) -> Void)?
    var didUpdate: ((ElementCellViewModel) -> Void)?
    var didSelectElement: ((Element) -> Void)?

    // MARK: - Properties
    var title: String {return self.element.title}
    var desc: String {return self.element.elementDescription}
    private(set) var image: UIImage?

    // MARK: - Actions
    func loadThumbnailImage() {
        guard self.image == nil else { return } //ignore if we already have an image
        guard self.imageCacheCancellable == nil else { return } //ignore if we are already fetching
        guard let url = self.element.photoURL else {return } //we dont need to download if url is null

        self.imageCacheCancellable = self.imageCache.image(at: url, callback: { [weak self] result in
            switch result {
            case .success(let image):
                guard let strongSelf = self else { return }
                
                strongSelf.image = image
                strongSelf.didUpdate?(strongSelf)
            case .error(let error):
                 print(error.localizedDescription)
            }
        })
    }
}

extension ElementCellViewModel: CellRepresentable {
    static func registerCell(tableView: UITableView) {
        tableView.register(UINib(nibName: "ElementCell", bundle: nil   ), forCellReuseIdentifier: "ElementCell")
    }
    func dequeueCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath) as! ElementCell
        cell.setup(viewModel: self)
        return cell
    }
    func cellSelected() {
        self.didSelectElement?(self.element)
    }
}
