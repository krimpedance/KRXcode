//
//  SceneDelegate.swift
//  KRXcodeTemplate
//
//  Copyright © KRXcodeYear KRXcodeOrganization. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    private var router: RootRouterProtocol!

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else { return }

        // Application
        _ = Application.shared

        // Router
        window = UIWindow(windowScene: scene)
        router = RootRouter(window: window!)
        router.start()
    }
}
