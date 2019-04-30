//
//  __PREFIX__Router.swift
//  __TARGET__
//
//  Copyright © __YEAR__ __ORGANIZATION__. All rights reserved.
//

import UIKit

// MARK: - Protocol ------------

protocol __PREFIX__RouterProtocol {
    static func assembleModule() -> UIViewController
}

// MARK: - Router ------------

final class __PREFIX__Router: __PREFIX__RouterProtocol {
    private weak var view: __PREFIX__ViewProtocol!

    init(view: __PREFIX__ViewProtocol) {
        self.view = view
    }
}

// MARK: - Static Actions ------------

extension __PREFIX__Router {
    static func assembleModule() -> UIViewController {
        let model = __PREFIX__Model()
        let view = UIStoryboard(name: "__PREFIX__", bundle: nil).instantiateViewController(type: __PREFIX__VC.self)
        let router = __PREFIX__Router(view: view)
        let presenter = __PREFIX__Presenter(view: view, model: model, router: router)
        view.inject(presenter: presenter)
        return view
    }
}

// MARK: - Actions ------------

extension __PREFIX__Router {
}
