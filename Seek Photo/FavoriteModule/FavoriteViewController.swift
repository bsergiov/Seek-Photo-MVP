//
//  FavoriteViewController.swift
//  Seek Photo
//
//  Created by BSergio on 02.05.2022.
//

import UIKit

class FavoriteViewController: UIViewController {
    
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
        30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.id, for: indexPath) as! FavoriteCollectionViewCell
        
        cell.setupCell()
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
    
}
