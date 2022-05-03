//
//  FavoritePresenter.swift
//  Seek Photo
//
//  Created by BSergio on 03.05.2022.
//

import Foundation

// MARK: - View Protocol
protocol FavoriteViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
    func presentDetailVC(model: DetailModel)
}

// MARK: - Presenter Protocol
protocol FavoritePresenterProtocol: AnyObject {
    var view: FavoriteViewProtocol { get }
    var model: [DetailModel]? { get }
    init(view: FavoriteViewProtocol)
    func fetchFavoritForDB()
    func tappedForItem(model: DetailModel)
}

class FavoritePresenter: FavoritePresenterProtocol {
    
    unowned var view: FavoriteViewProtocol
    var model: [DetailModel]?
    
    required init(view: FavoriteViewProtocol) {
        self.view = view
        fetchFavoritForDB()
    }
    
    func fetchFavoritForDB() {
        StorageManager.instance.fetch { [weak self] results in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.model = results.reversed()
                self.view.success()
            }
        }
    }
    
    func tappedForItem(model: DetailModel) {
        view.presentDetailVC(model: model)
    }
}
