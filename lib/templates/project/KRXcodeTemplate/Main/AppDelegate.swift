//
//  AppDelegate.swift
//  KRXcodeTemplate
//
//  Copyright © KRXcodeYear KRXcodeOrganization. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var router: RootRouterProtocol!

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Application
        _ = Application.shared

        // Router
        window = UIWindow()
        router = RootRouter(window: window!)
        router.start()

        return true
    }
}
