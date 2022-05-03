//
//  FavoriteCollectionViewCell.swift
//  Seek Photo
//
//  Created by BSergio on 02.05.2022.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    static let id = "FavoriteCollectionViewCell"
    var presenter: FavoriteCellPresenter!
    
    // MARK: - UI Elements
    lazy private var iconImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .avenirNext25()
        label.textColor = .darkGray
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Public Methodes
    func setupCell() {
        setupView()
        setupConstraints()
    }
}

// MARK: - Setup View
extension FavoriteCollectionViewCell {
    private func setupView() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
    }
}

// MARK: - Setup Constraints
extension FavoriteCollectionViewCell {
    private func setupConstraints() {
        //icon
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9),
            iconImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0)
        ])
        //title
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 25),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor)
        ])
    }
}

// MARK: - FavoriteCollectionViewCellProtocol
extension FavoriteCollectionViewCell: FavoriteCollectionViewCellProtocol {
    func setContent(img: UIImage, title: String) {
        setupView()
        setupConstraints()
        titleLabel.text = title
        iconImageView.image = img
    }
}
