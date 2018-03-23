//
//  ElementCell.swift
//  DemoApp
//
//  Created by Shabir Jan on 3/11/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import UIKit

class ElementCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet private var elementTitleLabel: UILabel!
    @IBOutlet private var elementDescriptionLabel: UILabel!
    @IBOutlet private var elementImageView: UIImageView!
    // MARK: - Public
    func setup(viewModel: ElementCellViewModel) {
        self.elementTitleLabel.text = viewModel.title
        self.elementDescriptionLabel.text = viewModel.desc
        self.elementImageView.image = viewModel.image ?? #imageLiteral(resourceName: "default")
        viewModel.didUpdate = self.setup
        viewModel.loadThumbnailImage()
    }
}
