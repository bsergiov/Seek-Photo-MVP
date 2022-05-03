//
//  MainTabBarController.swift
//  Seek Photo
//
//  Created by BSergio on 02.05.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupItems()
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .blue
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .gray
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.black.cgColor
    }
    
    private func setupItems() {
        let mainViewController = ModelBuilder.createMainModule()
        let favoriteViewController = FavoriteViewController()
        
        let mainNc = UINavigationController(rootViewController: mainViewController)
        let favoriteNc = UINavigationController(rootViewController: favoriteViewController)
        
        setViewControllers([mainNc, favoriteNc], animated: true)
        
        guard let items = tabBar.items else { return }
        items[0].title = "Home"
        items[1].title = "Favorite"
        
        items[0].image = UIImage(systemName: "house.fill")
        items[1].image = UIImage(systemName: "heart.circle")
    }
}
