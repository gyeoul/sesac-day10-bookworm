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
    let searchBar = UISearchBar()
    var searchList: [Movie] = []{
        didSet {
            collectionView.reloadData()
        }
    }
    var movie = MovieInfo() {
        didSet {
            collectionView.reloadData()
        }
    }

    @IBOutlet var navSearchButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "(user)님의 컬렉션"
        
        collectionView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        let itemSize = CGFloat(DEVICE_WIDTH - SPACING_VALUE * CGFloat(ITEM_ROW - 1) - INSET_VALUE - INSET_VALUE) / ITEM_ROW

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.sectionInset = UIEdgeInsets(top: INSET_VALUE, left: INSET_VALUE, bottom: INSET_VALUE, right: INSET_VALUE)
        layout.minimumLineSpacing = SPACING_VALUE
        layout.minimumInteritemSpacing = SPACING_VALUE
        layout.minimumInteritemSpacing = SPACING_VALUE

        collectionView.collectionViewLayout = layout

        navSearchButton.title = ""
        navSearchButton.image = UIImage(systemName: "magnifyingglass")
        navSearchButton.tintColor = .black
        
        searchBar.placeholder = "검색할 단어를 입력해 주세요"
        searchBar.delegate = self
//        searchBar.showsCancelButton = true
        searchBar.autocapitalizationType = .none
        
    }

    @IBAction func searchButtonClicked(_ sender: UIBarButtonItem) {
//        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        let vc: SearchViewController = storyBoard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
//        let nav = UINavigationController(rootViewController: vc)
//        nav.modalPresentationStyle = .fullScreen
//        present(nav, animated: true)
        if navigationItem.titleView ==  searchBar {
            navigationItem.titleView = .none
            navigationItem.title = "(user)님의 컬렉션"
        } else {
            navigationItem.titleView = searchBar
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchList.isEmpty {
            return movie.movie.count
        }
        return searchList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        var this:Movie = movie.movie[indexPath.row]
        if !searchList.isEmpty {
            this = searchList[indexPath.row]
        }
        
        cell.update(movie: this)
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(heartButtonClick), for: .touchUpInside)
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var this = searchList[indexPath.row]
        if searchList.isEmpty {
            this = movie.movie[indexPath.row]
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: DetailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
        vc.args = this
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc
    func heartButtonClick(_ sender: UIButton) {
        movie.movie[sender.tag].like.toggle()
    }
}

extension MovieListCollectionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let word = searchBar.text {
            searchAction(word)
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchText == "" {
            searchList.append(contentsOf: movie.movie)
            return
        }
        if let word = searchBar.text {
            searchAction(word)
        }
    }

    func searchAction(_ word: String) {
        searchList.removeAll()
        for item in movie.movie {
            if item.title.contains(word) {
                searchList.append(item)
                print(searchList)
            }
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchList.removeAll()
        searchBar.text = ""
    }
}
