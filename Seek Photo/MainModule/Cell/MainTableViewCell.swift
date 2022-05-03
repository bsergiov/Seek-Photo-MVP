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
        content.text = title
        content.image = img
        contentConfiguration = content
    }
}
