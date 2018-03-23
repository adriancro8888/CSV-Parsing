//
//  Navigation.swift
//  DemoApp
//
//  Created by Shabir Jan on 3/11/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import UIKit

class Coordinator {
    
    lazy var network = NetworkProvider(session: URLSession.shared)
    lazy var fileService = FileService()
    lazy var api: API = API(network: network, fileService: fileService)
    lazy var imageCache: ImageCache = ImageCacheProvider(network: self.network)
    // MARK: - Private
    private let navigationController: UINavigationController
    
    // MARK: - Lifecycle
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public
    func start() {
        self.showElementList()
    }
    
    // MARK: - Private
    private func showElementList() {
        
        let viewModel = ElementsViewModel(
            api: self.api,
            imageCache: self.imageCache,
            fileService: self.fileService
        )
        viewModel.didSelectElement = { [weak self] element in
            guard let strongSelf = self else { return }
            strongSelf.showElementDetail(element: element)
        }
        
        let instance = ElementsViewController(viewModel: viewModel)
        self.navigationController.pushViewController(instance, animated: false)
    }
    private func showElementDetail(element: Element) {
        let viewModel = ElementDetailViewModel(
            element: element,
            imageCache: self.imageCache
        )
        
        let instance = ElementDetailViewController(viewModel: viewModel)
        self.navigationController.pushViewController(instance, animated: true)
    }
}
