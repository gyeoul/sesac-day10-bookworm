//
//  DetailViewController.swift
//  sesac-day10-bookwarm
//
//  Created by 박창현 on 2023.07.31.
//

import UIKit

class DetailViewController: UIViewController {
    enum Presentation {
        case push, present
    }

    var presentationMode: Presentation = .push
    var args: Movie? = nil
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var descTextView: UITextView!
    @IBOutlet var posterImage: UIImageView!
    @IBOutlet var headerBackground: UIView!
    @IBOutlet var rateBackground: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let this = args {
//            title = this.title
            posterImage.image = UIImage(named: this.title)
            titleLabel.text = this.title
            infoLabel.text = "\(this.releaseDate) | \(this.runtime)분"
            rateLabel.text = "평균 ☆ \(this.rate)"
            descTextView.text = this.overview
        }
        headerBackground.backgroundColor = .darkGray
        rateBackground.backgroundColor = .white
        rateBackground.layer.cornerRadius = 8
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 20)
        infoLabel.textColor = .white
        infoLabel.font = .systemFont(ofSize: 12)
        rateLabel.textColor = .black
        rateLabel.font = .systemFont(ofSize: 12)
        descTextView.isEditable = false
        if presentationMode == .present {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        }
        navigationController?.navigationBar.tintColor = .white
    }

    @objc
    func closeButtonClicked() {
        dismiss(animated: true)
    }
}
