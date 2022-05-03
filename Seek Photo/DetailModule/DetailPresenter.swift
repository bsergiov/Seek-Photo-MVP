//
//  DetailPresenter.swift
//  Seek Photo
//
//  Created by BSergio on 03.05.2022.
//

import Foundation
import UIKit

// MARK: - View Protocol
protocol DetailViewProtocol: AnyObject {
    func setContent(img: UIImage, nameAuthor: String, createdAt: String, locationPublication: String, downloadsStatistic: String)
}

// MARK: - Presenter Protocol
protocol DetailPresenterProtocol: AnyObject {
    var view: DetailViewProtocol { get }
    var model: DetailModel { get }
    init(view: DetailViewProtocol, model: DetailModel)
    func showContent()
    func addedToFavorite()
    
}

class DetailPresenter: DetailPresenterProtocol {
    
    unowned var view: DetailViewProtocol
    var model: DetailModel
    
    required init(view: DetailViewProtocol, model: DetailModel) {
        self.view = view
        self.model = model
        showContent()
    }
    
    func showContent() {
        
        guard let img = UIImage(data: model.img) else { return }
        view.setContent(img: img,
                        nameAuthor: model.nameAuthor,
                        createdAt: model.createdAt,
                        locationPublication: model.location,
                        downloadsStatistic: "\(model.downloads)")
    }
    
    func addedToFavorite() {
        StorageManager.instance.save(model)
    }
}
