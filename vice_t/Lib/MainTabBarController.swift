//
//  MainTabBarController.swift
//  vice_t
//
//  Created by Pavle Mijatovic on 25.5.21..
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabs()
        setUI()
    }
    
    // MARK: - Helper
    private func setTabs() {
        let firstVC = MoviesVC.instantiate()
        let nc1 = UINavigationController(rootViewController: firstVC)
        nc1.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 0)
            
        let secondVC = FavoritesCollectionVC.instantiate()
        let nc2 = UINavigationController(rootViewController: secondVC)
        nc2.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)

        viewControllers = [nc1, nc2]
    }
    
    private func setUI() {
        // Navigation bar
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().tintColor = UIColor.themeColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = true
        // Tab bar
        UITabBar.appearance().tintColor = UIColor.themeColor
        UITabBar.appearance().barTintColor = .black
    }
}
