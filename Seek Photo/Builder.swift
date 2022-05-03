//
//  Builder.swift
//  Seek Photo
//
//  Created by BSergio on 03.05.2022.
//

import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
    static func createFavoriteModule() -> UIViewController
}

class ModelBuilder: Builder {
    
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let networkManager = NetworkManager()
        let presenter = MainModulePresenter(view: view, networkManager: networkManager)
        view.presenter = presenter
        return view
    }
    
    static func createFavoriteModule() -> UIViewController {
        let view = FavoriteViewController()
        
        return view
    }
    
}
