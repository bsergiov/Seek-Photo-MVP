//
//  MainModulePresenter.swift
//  Seek Photo
//
//  Created by BSergio on 03.05.2022.
//

import Foundation


// MARK: - Input Protocol
protocol MainViewProtocol: AnyObject {
    func setContent()
    func success()
    func failure(error: Error)
    func presentDetailVC(model: DetailModel)
}

// MARK: - Output Protocol
protocol MainPresenterProtocol: AnyObject {
    var model: [PictureModel]? { get set }
    init(view: MainViewProtocol)
    func fetchRandomPhoto()
    func fetchByKeyword(for keyword: String)
    func tappedForCell(model: PictureModel)
}

class MainModulePresenter: MainPresenterProtocol {
    unowned let view: MainViewProtocol
    var model: [PictureModel]?
    
    required init(view: MainViewProtocol) {
        self.view = view
        fetchRandomPhoto()
    }
    
    func fetchRandomPhoto() {
        NetworkManager.instance.fetch(dataType: [PictureModel].self) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let photos):
                    self.model = photos
                    self.view.success()
                case .failure(let error):
                    print("Error fetch Data \(error)")
                    self.view.failure(error: error)
                }
            }
        }
    }
    
    func fetchByKeyword(for keyword: String) {
        NetworkManager.instance.fetch(dataType: SearchModel.self, query: keyword) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let searchModel):
                    guard let pictures = searchModel.results else { return }
                    if pictures.isEmpty { return }
                    self.model = pictures
                    self.view.setContent()
                case .failure(let error):
                    print("Not result \(error)")
                }
            }
        }
    }
    
    func tappedForCell(model: PictureModel) {
        NetworkManager.instance.fetchData(from: model.urls.small) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                let detailModel = DetailModel()
                detailModel.createdAt = model.createdAt
                detailModel.nameAuthor = model.user.name
                detailModel.img = data
                detailModel.location = model.user.location ?? "Private Location"
                detailModel.downloads = model.downloads ?? 0
                self.view.presentDetailVC(model: detailModel)
            case .failure(let error):
                print("Error fetch dataImg \(error)")
            }
        }
    }
}
