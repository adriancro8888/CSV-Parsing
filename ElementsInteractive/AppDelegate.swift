//
//  AppDelegate.swift
//  ElementsInteractive
//
//  Created by Shabir Jan on 3/10/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: Coordinator!
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        let nav = UINavigationController()
        window?.rootViewController = nav
        appCoordinator = Coordinator(navigationController: nav)
        appCoordinator.start()
        window?.makeKeyAndVisible()
        return true
    }
}
