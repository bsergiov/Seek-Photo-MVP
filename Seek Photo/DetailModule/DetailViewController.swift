//
//  DetailViewController.swift
//  Seek Photo
//
//  Created by BSergio on 02.05.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Public Properties
    var presenter: DetailPresenterProtocol!
    
    // MARK: - UI Elements
    lazy private var imageMainImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy private var nameAuthorLabel: UILabel = {
        let label = UILabel()
        label.text = "nameAuthorLabel"
        label.font = .avenirNext25()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var createdAtLabel: UILabel = {
        let label = UILabel()
        label.text = "createdAtLabel"
        label.font = .avenirNext17()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var locationPublicationLabel: UILabel = {
        let label = UILabel()
        label.text = "locationPublicationLabel"
        label.font = .avenirNext17()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var downloadsStatisticLabel: UILabel = {
        let label = UILabel()
        label.text = "downloadsStatisticLabel"
        label.font = .avenirNext17()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var favoriteButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = .gray
        button.setTitle("add to favorite", for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(tappedFavoriteButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVeiew()
        setupConstraints()
    }
}

// MARK: - Action Methodes
extension DetailViewController {
    @objc private func tappedFavoriteButton(_ sender: UIButton) {
        guard let textButton = sender.titleLabel?.text else { return }
        presenter.actionUserForFavorite(actionText: textButton)
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Setup View
extension DetailViewController {
    private func setupVeiew() {
        view.backgroundColor = .white
        view.addSubview(imageMainImageView)
        view.addSubview(nameAuthorLabel)
        view.addSubview(createdAtLabel)
        view.addSubview(locationPublicationLabel)
        view.addSubview(downloadsStatisticLabel)
        view.addSubview(favoriteButton)
    }
}

// MARK: - Setup Constraints
extension DetailViewController {
    private func setupConstraints() {
        //imageMainImageView
        NSLayoutConstraint.activate([
            imageMainImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            imageMainImageView.heightAnchor.constraint(equalTo: imageMainImageView.widthAnchor),
            imageMainImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageMainImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
        //nameAuthorLabel
        NSLayoutConstraint.activate([
            nameAuthorLabel.heightAnchor.constraint(equalToConstant: 25),
            nameAuthorLabel.topAnchor.constraint(equalTo: imageMainImageView.bottomAnchor, constant: 0),
            nameAuthorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nameAuthorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        //createdAtLabel
        NSLayoutConstraint.activate([
            createdAtLabel.heightAnchor.constraint(equalToConstant: 20),
            createdAtLabel.widthAnchor.constraint(equalToConstant: 200),
            createdAtLabel.topAnchor.constraint(equalTo: nameAuthorLabel.bottomAnchor, constant: 20),
            createdAtLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
        //locationPublicationLabel
        NSLayoutConstraint.activate([
            locationPublicationLabel.heightAnchor.constraint(equalToConstant: 20),
            locationPublicationLabel.widthAnchor.constraint(equalToConstant: 200),
            locationPublicationLabel.topAnchor.constraint(equalTo: createdAtLabel.bottomAnchor, constant: 5),
            locationPublicationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
        //downloadsStatisticLabel
        NSLayoutConstraint.activate([
            downloadsStatisticLabel.heightAnchor.constraint(equalToConstant: 20),
            downloadsStatisticLabel.widthAnchor.constraint(equalToConstant: 200),
            downloadsStatisticLabel.topAnchor.constraint(equalTo: locationPublicationLabel.bottomAnchor, constant: 5),
            downloadsStatisticLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
        //favoriteButton
        NSLayoutConstraint.activate([
            favoriteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            favoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            favoriteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
}

// MARK: - DetailViewProtocol
extension DetailViewController: DetailViewProtocol {
    
    func setContent(img: UIImage, nameAuthor: String, createdAt: String, locationPublication: String, downloadsStatistic: String, textButton: String) {
        imageMainImageView.image = img
        nameAuthorLabel.text = nameAuthor
        createdAtLabel.text = createdAt
        locationPublicationLabel.text = locationPublication
        downloadsStatisticLabel.text = downloadsStatistic
        favoriteButton.setTitle(textButton, for: .normal)
    }
}
