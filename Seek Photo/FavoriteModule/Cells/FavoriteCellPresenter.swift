//
//  FavoriteCellPresenter.swift
//  Seek Photo
//
//  Created by BSergio on 03.05.2022.
//

import Foundation
import UIKit

// MARK: - View Protocol
protocol FavoriteCollectionViewCellProtocol: AnyObject {
    func setContent(img: UIImage, title: String)
}

protocol FavoriteCellPresenterPresenter: AnyObject {
    var view: FavoriteCollectionViewCellProtocol { get }
    var model: DetailModel { get }
    init(view: FavoriteCollectionViewCellProtocol, model: DetailModel)
    func showContent()
}


class FavoriteCellPresenter: FavoriteCellPresenterPresenter {
    
    unowned var view: FavoriteCollectionViewCellProtocol
    
    var model: DetailModel
    
    required init(view: FavoriteCollectionViewCellProtocol, model: DetailModel) {
        self.view = view
        self.model = model
        showContent()
    }
    
    func showContent() {
        guard let image = UIImage(data: model.img) else { return }
        DispatchQueue.main.async {
            self.view.setContent(img: image, title: self.model.nameAuthor)
        }
    }
}
