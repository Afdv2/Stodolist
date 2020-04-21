//
//  AppDelegate.swift
//  stodo
//
//  Created by Alexandr on 12.04.2020.
//  Copyright © 2020 clean-code.club. All rights reserved.  
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let listsViewController = ListsConfigurator().configure(shouldMock: true)
        let rootViewController = UINavigationController(rootViewController: listsViewController)
        window?.rootViewController = rootViewController
        return true
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "stodoModel")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        
        return container
    }()
}

