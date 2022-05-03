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
}

// MARK: - Output Protocol
protocol MainPresenterProtocol: AnyObject {
    var model: [PictureModel]? { get set }
    var networkManager: NetworkManagerProtocol { get }
    init(view: MainViewProtocol, networkManager: NetworkManagerProtocol)
    func fetchRandomPhoto()
    func fetchByKeyword(for keyword: String)
}

class MainModulePresenter: MainPresenterProtocol {
   
    unowned let view: MainViewProtocol
    let networkManager: NetworkManagerProtocol
    var model: [PictureModel]?
    
    required init(view: MainViewProtocol, networkManager: NetworkManagerProtocol) {
        self.view = view
        self.networkManager = networkManager
        fetchRandomPhoto()
    }
    
    func fetchRandomPhoto() {
        networkManager.fetch(dataType: [PictureModel].self) { [weak self] result in
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
        networkManager.fetch(dataType: SearchModel.self, query: keyword) { [weak self] result in
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
}
