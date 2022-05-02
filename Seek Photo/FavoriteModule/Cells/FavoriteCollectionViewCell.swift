//
//  FavoriteCollectionViewCell.swift
//  Seek Photo
//
//  Created by BSergio on 02.05.2022.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    static let id = "FavoriteCollectionViewCell"
    
    // MARK: - UI Elements
    lazy private var iconImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next", size: 30)
        label.text = "ku"
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
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor)
        ])
    }
}
