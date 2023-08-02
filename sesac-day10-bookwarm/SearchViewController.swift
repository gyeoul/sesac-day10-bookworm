//
//  SearchViewController.swift
//  sesac-day10-bookwarm
//
//  Created by 박창현 on 2023.07.31.
//

import UIKit

class SearchViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        title = "검색화면"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }

    @objc
    func closeButtonClicked() {
        dismiss(animated: true)
    }
}
