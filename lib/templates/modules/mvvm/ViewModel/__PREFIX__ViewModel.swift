//
//  __PREFIX__Presenter.swift
//  __TARGET__
//
//  Copyright © __YEAR__ __ORGANIZER__. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - ViewModel protocol ------------

protocol __PREFIX__ViewModelProtocol {
}

// MARK: - ViewModel ------------

final class __PREFIX__ViewModel: __PREFIX__ViewModelProtocol {
    private let bag = DisposeBag()
    private let model: __PREFIX__ModelProtocol

    // Public properties ------------

    // Initializers ------------

    init(model: __PREFIX__ModelProtocol) {
        self.model = model
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
