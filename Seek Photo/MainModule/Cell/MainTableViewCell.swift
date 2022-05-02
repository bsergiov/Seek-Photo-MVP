//
//  MainTableViewCell.swift
//  Seek Photo
//
//  Created by BSergio on 02.05.2022.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    static let id = "MainTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    
    // MARK: - Public Methodes
    func setupCell() {
        var content = defaultContentConfiguration()
        content.text = "Ku"
        content.image = UIImage(systemName: "person")
        contentConfiguration = content
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
