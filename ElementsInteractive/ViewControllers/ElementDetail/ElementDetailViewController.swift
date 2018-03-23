//
//  ElementDetailViewController.swift
//  DemoApp
//
//  Created by Shabir Jan on 3/11/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import UIKit

class ElementDetailViewController: UIViewController {

    @IBOutlet weak var elementDescriptionLabel: UILabel!
    @IBOutlet weak var elementTitleLabel: UILabel!
    @IBOutlet weak var elementImageView: UIImageView!
    // MARK: - Private
    private var viewModel: ElementDetailViewModel!

    // MARK: - Lifecycle
    convenience init(viewModel: ElementDetailViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModelDidUpdate()
        self.bindToViewModel()
    }

    // MARK: - ViewModel
    private func bindToViewModel() {
        self.viewModel.didUpdate = { [weak self] in
            self?.viewModelDidUpdate()
        }
        self.viewModel.didError = { [weak self] error in
            self?.viewModelDidError(error: error)
        }
    }
    private func viewModelDidUpdate() {
        elementImageView.image = viewModel.image
        elementTitleLabel.text = viewModel.title
        elementDescriptionLabel.text = viewModel.desc
    }
    private func viewModelDidError(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
