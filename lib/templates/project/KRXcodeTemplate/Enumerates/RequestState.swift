//
//  RequestState.swift
//  KRXcodeTemplate
//
//  Copyright © KRXcodeYear KRXcodeOrganization. All rights reserved.
//

import Foundation

enum RequestState: Equatable {
    case none, requesting, error(String)

    var rawValue: Int {
        switch self {
        case .none: return 0
        case .requesting: return 1
        case .error: return 2
        }
    }

    static func == (lhs: RequestState, rhs: RequestState) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none), (.requesting, .requesting): return true
        case (.error(let lMsg), .error(let rMsg)): return lMsg == rMsg
        default: return false
        }
    }
}
