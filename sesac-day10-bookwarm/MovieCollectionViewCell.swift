//
//  MovieCollectionViewCell.swift
//  sesac-day10-bookwarm
//
//  Created by 박창현 on 2023.07.31.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet var bgView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    
    func update(movie:Movie) {
        titleLabel.textColor = .white
        rateLabel.textColor = .white
        likeButton.tintColor = .white
        likeButton.setTitle("", for: .normal)
        
        if movie.like {
            self.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            self.likeButton.setImage(UIImage(systemName: "heart"), for: .highlighted)
        } else {
            self.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            self.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .highlighted)
        }
    }
}
