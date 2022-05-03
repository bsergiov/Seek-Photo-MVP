//
//  MainTableViewCell.swift
//  Seek Photo
//
//  Created by BSergio on 02.05.2022.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    // MARK: - Public Properties
    static let id = "MainTableViewCell"
    
    var presenter: MainTableViewCellPresenterProtocol!
}

// MARK: - MainTableViewCellProtocol
extension MainTableViewCell: MainTableViewCellProtocol {
    func setContent(title: String, img: UIImage) {
       
        var content = defaultContentConfiguration()
        content.imageProperties.maximumSize.width = 50
        content.imageProperties.maximumSize.height = 50
        content.imageProperties.cornerRadius = content.image?.size.height ?? 50 / 2
        content.text = title
        content.image = img
        contentConfiguration = content
    }
}
