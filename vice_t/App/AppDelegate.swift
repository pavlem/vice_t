//
//  AppDelegate.swift
//  vice_t
//
//  Created by Pavle Mijatovic on 24.5.21..
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // MARK: - Lifecycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        setRootVC()
        return true
    }
    
    // MARK: - Helper
    private func setRootVC() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainTabBarController()
        window?.makeKeyAndVisible()
    }
}
