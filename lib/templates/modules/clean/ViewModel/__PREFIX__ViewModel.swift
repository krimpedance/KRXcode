//
//  __PREFIX__Presenter.swift
//  __TARGET__
//
//  Copyright © __YEAR__ __ORGANIZATION__. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - ViewModel protocol ------------

protocol __PREFIX__ViewModelProtocol {
}

// MARK: - ViewModel ------------

final class __PREFIX__ViewModel: __PREFIX__ViewModelProtocol {
    private let bag = DisposeBag()
    private let router: __PREFIX__RouterProtocol
    private let presenter: __PREFIX__PresenterProtocol

    // Public properties ------------

    // Initializers ------------

    init(presenter: __PREFIX__PresenterProtocol, router: __PREFIX__RouterProtocol) {
        self.presenter = presenter
        self.router = router
        subscribe()
    }
}

// MARK: - Private actions ------------

private extension __PREFIX__ViewModel {
    func subscribe() {
    }
}

// MARK: - Actions ------------

extension __PREFIX__ViewModel {
}
