//
//  FavoriteViewController.swift
//  Seek Photo
//
//  Created by BSergio on 02.05.2022.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    // MARK: - Public Properties
    var presenter: FavoritePresenter!
    
    // MARK: - UI Elements
    lazy private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .none
        return collectionView
    }()
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstaints()
        setupDelegate()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.fetchFavoritForDB()
    }
}

// MARK: - Setup View
extension FavoriteViewController {
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
    }
}

// MARK: - Setup Delegate
extension FavoriteViewController {
    private func setupDelegate() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension FavoriteViewController {
    private func registerCell() {
        collectionView.register(FavoriteCollectionViewCell.self,
                                forCellWithReuseIdentifier: FavoriteCollectionViewCell.id)
    }
}

// MARK: - Setup Constraints
extension FavoriteViewController {
    private func setupConstaints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension FavoriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.model?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.id, for: indexPath) as! FavoriteCollectionViewCell
        guard let photos = presenter.model else { return cell}
        let presenterCell = FavoriteCellPresenter(view: cell, model: photos[indexPath.row])
        cell.presenter = presenterCell
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width - 32, height: 90)
    }
}

// MARK: - UICollectionViewDelegate
extension FavoriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //navigation
        guard let photos = presenter.model else { return }
        presenter.tappedForItem(model: photos[indexPath.item])
    }
}

// MARK: -
extension FavoriteViewController: FavoriteViewProtocol {
    func setContent() {
        
    }
    
    func success() {
        collectionView.reloadData()
    }
    
    func failure(error: Error) {
        // TODO allert
    }
    
    func presentDetailVC(model: DetailModel) {
        let detailViewController = DetailViewController()
        let presenterDetail = DetailPresenter(view: detailViewController, model: model)
        detailViewController.presenter = presenterDetail
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
