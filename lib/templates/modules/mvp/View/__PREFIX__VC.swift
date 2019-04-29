//
//  __PREFIX__VC.swift
//  __TARGET__
//
//  Copyright © __YEAR__ __ORGANIZER__. All rights reserved.
//

import UIKit

final class __PREFIX__VC: UIViewController, Transitioner {
    private var presenter: __PREFIX__PresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        presenter.viewDidLoad()
    }
}

// MARK: - Private actions ------------

private extension __PREFIX__VC {
    func setUp() {
    }
}

// MARK: - Actions ------------

extension __PREFIX__VC {
    func inject(presenter: __PREFIX__PresenterProtocol) {
        self.presenter = presenter
    }
}

// MARK: - __PREFIX__ViewProtocol ------------

extension __PREFIX__VC: __PREFIX__ViewProtocol {
}
