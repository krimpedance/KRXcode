//
//  __PREFIX__Presenter.swift
//  __TARGET__
//
//  Copyright © __YEAR__ __ORGANIZER__. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - ViewData ------------

struct __PREFIX__ViewData {
}

// MARK: - Presenter protocol ------------

protocol __PREFIX__PresenterProtocol {
    var data: Observable<__PREFIX__ViewData> { get }
}

// MARK: - Presenter ------------

final class __PREFIX__Presenter: __PREFIX__PresenterProtocol {
    private let bag = DisposeBag()
    private let useCase: __PREFIX__UseCaseProtocol

    private let dataSub: BehaviorSubject<__PREFIX__ViewData>

    var data: Observable<__PREFIX__ViewData> { return dataSub }

    init(useCase: __PREFIX__UseCaseProtocol) {
        self.useCase = useCase
        dataSub = .init(value: .init())
    }
}

// MARK: - Actions ------------

extension __PREFIX__Presenter {
}
