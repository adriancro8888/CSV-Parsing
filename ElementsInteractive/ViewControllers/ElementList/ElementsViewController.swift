//
//  ViewController.swift
//  DemoApp
//
//  Created by Shabir Jan on 3/10/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import UIKit

class ElementsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private var tableView: UITableView!

    // MARK: - Private
    private var viewModel: ElementsViewModel!

    // MARK: - Lifecycle
    required convenience init(viewModel: ElementsViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = self.viewModel.title

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Refresh", style: .plain,
            target: self, action: #selector(ElementsViewController.reloadData)
        )
        viewModel.elementViewModelsTypes.forEach { $0.registerCell(tableView: tableView) }
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindToViewModel()
        reloadData()
    }
    // MARK: - ViewModel
    private func bindToViewModel() {
        viewModel.didUpdate = { [weak self] _ in
            self?.viewModelDidUpdate()
        }
        viewModel.didError = { [weak self] error in
            self?.viewModelDidError(error: error)
        }
    }
    private func viewModelDidUpdate() {
        title = viewModel.title
        navigationItem.rightBarButtonItem?.isEnabled = !viewModel.isUpdating
        tableView.reloadData()
    }
    private func viewModelDidError(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    // MARK: - Actions
    @objc private func reloadData() {
        viewModel.reloadData()
    }
}

extension ElementsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.elementViewModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.elementViewModels[indexPath.row]
            .dequeueCell(tableView: tableView, indexPath: indexPath)
    }
}
extension ElementsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.elementViewModels[indexPath.row].cellSelected()
    }
}
