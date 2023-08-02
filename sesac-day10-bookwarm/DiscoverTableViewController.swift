//
//  DiscoverTableViewController.swift
//  sesac-day10-bookworm
//
//  Created by Gyeoul on 2023/08/02.
//

import UIKit

class DiscoverTableViewController: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet var tableCollectionView: UICollectionView!

    var movie = MovieInfo() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "둘러보기"
        tableView.register(UINib(nibName: DiscoverTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DiscoverTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableCollectionView.dataSource = self
        tableCollectionView.delegate = self
        tableCollectionView.register(UINib(nibName: DiscoverTableCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DiscoverTableCollectionViewCell.identifier)
        configureTableCollectionViewLayout()
//        tableCollectionView.
//        cell item 사이즈에 맞춰 tableCollectionView 크기 조절..?
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.movie.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DiscoverTableViewCell.identifier) as? DiscoverTableViewCell
        else {
            return UITableViewCell()
        }
        let this = movie.movie[indexPath.row]
        cell.titleLabel.text = this.title
        cell.descLabel.text = "\(this.releaseDate.split(separator: ".")[0]) - \(this.rate)"
        cell.posterImage.image = UIImage(named: this.title)
//        cell.backgroundUiView.backgroundColor = .systemOrange
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie.movie.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverTableCollectionViewCell.identifier, for: indexPath) as? DiscoverTableCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        let this = movie.movie[indexPath.row]
        cell.titleLabel.text = this.title
        cell.posterImage.image = UIImage(named: this.title)
        return cell
    }

    func configureTableCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3, height: 200)
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        height를 자동으로 조절하게 하는 방법은 없을까?
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        tableCollectionView.collectionViewLayout = layout
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showModalPesent(tableView, index: indexPath)
//        아이템 선택 후 배경 초기화?
// X      tableView.backgroundColor = .clear
// O      tableView.reloadRows(at: [indexPath], with: .none)
//        다형성으로 처리가 가능할 것 같다
    }

//    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {}

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showModalPesent(collectionView, index: indexPath)
    }

    func showModalPesent(_ view: UIView, index: IndexPath) {
        let this = movie.movie[index.row]
        // 다형성을 이용한 배경색 초기화
        // 코드를 조금 더 줄일 수 있는 방법은 없을까?
        if let cell = view as? UICollectionView {
            cell.reloadItems(at: [index])
        }
        if let cell = view as? UITableView {
            cell.reloadRows(at: [index], with: .none)
        }
        guard let vc: DetailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        else {
            return
        }
        let nav = UINavigationController(rootViewController: vc)
//        네비바에 아이템 추가는 꼭 디테일 뷰에서 해주어야하나?
//        하지만 네비뷰에서 추가할 경우 기존 네비바와 충돌 가능성이 있는데..
//        nav.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
//        nav.navigationBar.tintColor = .black
//        잘 추가되지 않는다...
        vc.args = this
        present(nav, animated: true)
    }

    @objc
    func closeButtonClicked() {
        dismiss(animated: true)
    }
}
