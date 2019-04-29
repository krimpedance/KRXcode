//
//  RootRouter.swift
//  KRXcodeTemplate
//
//  Copyright © KRXcodeYear KRXcodeOrganization. All rights reserved.
//

import UIKit

protocol RootRouterProtocol {
    func start()
}

final class RootRouter: RootRouterProtocol {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }
}

// MARK: - Private actions ------------

private extension RootRouter {
}

// MARK: - Actions ------------

extension RootRouter {
    func start() {
//        window.rootViewController = MainRouter.assembleModule()
        window.makeKeyAndVisible()
    }
}
