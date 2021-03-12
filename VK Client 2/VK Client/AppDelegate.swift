//
//  AppDelegate.swift
//  VK Client
//
//  Created by Regina Galishanova on 19.12.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupAppearance()
        return true
        
    }
    func setupAppearance() {
        UINavigationBar.appearance().barTintColor = .darkGray
        UINavigationBar.appearance().backgroundColor = #colorLiteral(red: 0.2339640558, green: 0.2541764975, blue: 0.2812632024, alpha: 1)
        UINavigationBar.appearance().tintColor = .white
        UITabBar.appearance().backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        UITabBar.appearance().barTintColor = #colorLiteral(red: 0.1978857815, green: 0.2135101259, blue: 0.2394730747, alpha: 1)
        UICollectionView.appearance().backgroundColor = #colorLiteral(red: 0.2339640558, green: 0.2541764975, blue: 0.2812632024, alpha: 1)
        UITableView.appearance().backgroundColor = #colorLiteral(red: 0.2339640558, green: 0.2541764975, blue: 0.2812632024, alpha: 1)

    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

