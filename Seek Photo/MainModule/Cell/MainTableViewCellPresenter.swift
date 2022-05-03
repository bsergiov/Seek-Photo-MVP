//
//  MainTableViewCellPresenter.swift
//  Seek Photo
//
//  Created by BSergio on 03.05.2022.
//

import Foundation
import UIKit

// MARK: - View Protocol
protocol MainTableViewCellProtocol: AnyObject {
    func setContent(title: String, img: UIImage)
}

// MARK: - Preseneter Protocol
protocol MainTableViewCellPresenterProtocol: AnyObject {
    var view: MainTableViewCellProtocol { get }
    var model: PictureModel { get }
    init(view: MainTableViewCellProtocol, model: PictureModel)
    func showContent()
    func showSpiner()
}

class MainTableViewCellPresenter: MainTableViewCellPresenterProtocol {
    
    unowned let view: MainTableViewCellProtocol
    var model: PictureModel
    
    required init(view: MainTableViewCellProtocol, model: PictureModel) {
        self.model = model
        self.view = view
        showContent()
    }
    
    func showContent() {
        let networkManager = NetworkManager()
        DispatchQueue.main.async {
            networkManager.fetchData(from: self.model.urls.thumb) {[weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    guard let image = UIImage(data: data) else { return }
                    self.view.setContent(title: self.model.user.name, img: image)
                case .failure(let error):
                    print("error fetch data image \(error)")
                }
            }
        }
    }
    
    func showSpiner() {
        
    } 
}
