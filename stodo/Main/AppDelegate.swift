//
//  AppDelegate.swift
//  stodo
//
//  Created by Alexandr on 12.04.2020.
//  Copyright © 2020 clean-code.club. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let viewController = ListsViewController()
        viewController.view.backgroundColor = .red
        window?.rootViewController = viewController
        // Override point for customization after application launch.
        return true
    }
}

