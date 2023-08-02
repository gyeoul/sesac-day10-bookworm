//
//  DiscoverTableViewCell.swift
//  sesac-day10-bookworm
//
//  Created by Gyeoul on 2023/08/02.
//

import UIKit

class DiscoverTableViewCell: UITableViewCell {
    @IBOutlet var backgroundUiView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var posterImage: UIImageView!
    static let identifier = "DiscoverTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textColor = .label
        descLabel.font = .systemFont(ofSize: 12)
        descLabel.textColor = .secondaryLabel
        backgroundUiView.layer.cornerRadius = 12
        posterImage.contentMode = .scaleAspectFill
        posterImage.layer.cornerRadius = 12
        posterImage.clipsToBounds = true
    }
}
