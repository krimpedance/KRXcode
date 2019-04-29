//
//  __PREFIX__Presenter.swift
//  __TARGET__
//
//  Copyright © __YEAR__ __ORGANIZER__. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Presenter protocol ------------

protocol __PREFIX__PresenterProtocol {
}

// MARK: - Presenter ------------

final class __PREFIX__Presenter: __PREFIX__PresenterProtocol {
    private let bag = DisposeBag()
    private let router: __PREFIX__RouterProtocol
    private let viewModel: __PREFIX__ViewModelProtocol

    init(router: __PREFIX__RouterProtocol, viewModel: __PREFIX__ViewModelProtocol) {
        self.router = router
        self.viewModel = viewModel
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
}
