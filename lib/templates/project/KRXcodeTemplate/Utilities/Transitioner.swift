//
//  Transitioner.swift
//  KRXcodeTemplate
//
//  Copyright © KRXcodeYear KRXcodeOrganization. All rights reserved.
//
//  swiftlint:disable identifier_name

import UIKit

protocol Transitioner {
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    func popViewController(animated: Bool)
    func popToRootViewController(animated: Bool)
    func popToViewController(_ viewController: UIViewController, animated: Bool)
    func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    func dismiss(animated: Bool)
}

extension Transitioner where Self: UIViewController {
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        guard let nc = navigationController else { fatalError() }
        nc.pushViewController(viewController, animated: animated)
    }

    func popViewController(animated: Bool) {
        guard let nc = navigationController else { fatalError() }
        nc.popViewController(animated: animated)
    }

    func popToRootViewController(animated: Bool) {
        guard let nc = navigationController else { fatalError() }
        nc.popToRootViewController(animated: animated)
    }

    func popToViewController(_ viewController: UIViewController, animated: Bool) {
        guard let nc = navigationController else { fatalError() }
        nc.popToViewController(viewController, animated: animated)
    }

    func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        present(viewController, animated: animated, completion: completion)
    }

    func dismiss(animated: Bool) {
        dismiss(animated: animated, completion: nil)
    }
}
