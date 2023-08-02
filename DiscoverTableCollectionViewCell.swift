//
//  DiscoverTableCollectionViewCell.swift
//  sesac-day10-bookworm
//
//  Created by Gyeoul on 2023/08/02.
//

import UIKit

class DiscoverTableCollectionViewCell: UICollectionViewCell {
    @IBOutlet var backgroundUiView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var posterImage: UIImageView!
    static let identifier = "DiscoverTableCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = .systemFont(ofSize: 12)
        titleLabel.textColor = .label
        posterImage.contentMode = .scaleAspectFill
        posterImage.layer.cornerRadius = 4
        posterImage.clipsToBounds = true
    }
}
