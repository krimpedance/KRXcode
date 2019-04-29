//
//  __PREFIX__Presenter.swift
//  __TARGET__
//
//  Copyright © __YEAR__ __ORGANIZER__. All rights reserved.
//

import Foundation

// MARK: - Presenter protocol ------------

protocol __PREFIX__PresenterProtocol {
    func viewDidLoad()
}

// MARK: - View protocol ------------

protocol __PREFIX__ViewProtocol: class {
}

// MARK: - Presenter ------------

final class __PREFIX__Presenter: __PREFIX__PresenterProtocol {
    private let model: __PREFIX__ModelProtocol
    private let router: __PREFIX__RouterProtocol
    private weak var view: __PREFIX__ViewProtocol!

    init(view: __PREFIX__ViewProtocol, model: __PREFIX__ModelProtocol, router: __PREFIX__RouterProtocol) {
        self.view = view
        self.model = model
        self.router = router
        subscribe()
    }
}

// MARK: - Private actions ------------

private extension __PREFIX__Presenter {
    func subscribe() {
    }
}

// MARK: - Actions ------------

extension __PREFIX__Presenter {
    func viewDidLoad() {
    }
}
