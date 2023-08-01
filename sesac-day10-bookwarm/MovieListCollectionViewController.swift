//
//  MovieListCollectionViewController.swift
//  sesac-day10-bookwarm
//
//  Created by 박창현 on 2023.07.31.
//

import UIKit

private let reuseIdentifier = "MovieCollectionViewCell"

class MovieListCollectionViewController: UICollectionViewController {
    let DEVICE_WIDTH: CGFloat = UIScreen.main.bounds.width
    let INSET_VALUE: CGFloat = 8
    let SPACING_VALUE: CGFloat = 0
    let ITEM_ROW: CGFloat = 2
    @IBOutlet var navSearchButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        let layout = UICollectionViewFlowLayout()
        let itemSize = CGFloat(DEVICE_WIDTH - SPACING_VALUE * CGFloat(ITEM_ROW - 1) - INSET_VALUE - INSET_VALUE) / ITEM_ROW
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.sectionInset = UIEdgeInsets(top: INSET_VALUE, left: INSET_VALUE, bottom: INSET_VALUE, right: INSET_VALUE)
        layout.minimumLineSpacing = SPACING_VALUE
        layout.minimumInteritemSpacing = SPACING_VALUE
        layout.minimumInteritemSpacing = SPACING_VALUE
        collectionView.collectionViewLayout = layout
        navSearchButton.title = ""
        navSearchButton.image = UIImage(systemName: "magnifyingglass")
        navSearchButton.tintColor = .black
    }
    
    @IBAction func searchButtonClicked(_ sender: UIBarButtonItem) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc: SearchViewController = storyBoard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovieInfo().movie.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        let this = MovieInfo().movie[indexPath.row]
        cell.posterImageView.image = UIImage(named: this.title)
        cell.bgView.layer.cornerRadius = 12
        cell.bgView.backgroundColor = getRandomColor()
        cell.rateLabel.text = "\(this.rate)"
        cell.titleLabel.text = this.title
        cell.rateLabel.textColor = .white
        cell.titleLabel.textColor = .white
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let this = MovieInfo().movie[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: DetailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
        vc.args = this
        
        //        present(vc, animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    func getRandomColor() -> UIColor {
        let randomRed = CGFloat(drand48() * 0.8 + 0.1)
        let randomGreen = CGFloat(drand48() * 0.8 + 0.1)
        let randomBlue = CGFloat(drand48() * 0.8 + 0.1)
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}
