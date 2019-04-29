//
//  __PREFIX__Router.swift
//  __TARGET__
//
//  Copyright © __YEAR__ __ORGANIZER__. All rights reserved.
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
        let useCase = __PREFIX__UseCase()

        let gateway = __PREFIX__Gateway()
        useCase.gateway = gateway

        let view = UIStoryboard(name: "__PREFIX__", bundle: nil).instantiateViewController(type: __PREFIX__VC.self)
        let router = __PREFIX__Router(view: view)
        let presenter = __PREFIX__Presenter(useCase: useCase)
        let viewModel = __PREFIX__ViewModel(presenter: presenter, router: router)
        view.inject(viewModel: viewModel)

        return view
    }
}

// MARK: - Actions ------------

extension __PREFIX__Router {
}
