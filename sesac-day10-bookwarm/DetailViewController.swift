//
//  DetailViewController.swift
//  sesac-day10-bookwarm
//
//  Created by 박창현 on 2023.07.31.
//

import UIKit

class DetailViewController: UIViewController {
    var args: Movie? = nil
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var descTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let this = args {
            title = this.title
            titleLabel.text = this.title
            infoLabel.text = "\(this.releaseDate) | \(this.runtime)분"
            rateLabel.text = "☆ \(this.rate)"
            descTextView.text = this.overview
        }
        descTextView.isEditable = false
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
