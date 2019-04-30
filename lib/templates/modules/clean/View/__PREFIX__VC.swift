//
//  __PREFIX__VC.swift
//  __TARGET__
//
//  Copyright © __YEAR__ __ORGANIZATION__. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol __PREFIX__ViewProtocol: class, Transitioner {
}

final class __PREFIX__VC: UIViewController, __PREFIX__ViewProtocol {

    private let bag = DisposeBag()

    private var viewModel: __PREFIX__ViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        subscribe()
    }
}

// MARK: - Private actions ------------

private extension __PREFIX__VC {
    func subscribe() {
    }
}

// MARK: - Actions ------------

extension __PREFIX__VC {
    func inject(viewModel: __PREFIX__ViewModelProtocol) {
        self.viewModel = viewModel
    }
}
