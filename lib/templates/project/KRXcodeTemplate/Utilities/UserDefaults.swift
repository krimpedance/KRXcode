//
//  UserDefaults.swift
//  KRXcodeTemplate
//
//  Copyright © KRXcodeYear KRXcodeOrganization. All rights reserved.
//

import KRFramework

struct Defaults: ObjectUserDefaultable, StringUserDefaultable, DateUserDefaultable, BoolUserDefaultable {
    enum ObjectDefaultKey: String {
        case objectKeyName
    }

    enum StringDefaultKey: String {
        case stringKeyName
    }

    enum DateDefaultKey: String {
        case dateKeyName
    }

    enum BoolDefaultKey: String {
        case boolKeyName
    }
}
