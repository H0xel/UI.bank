//
//  RegisterClientViewAssembly.swift
//  UIBank
//
//  Created by Ivan Amakhin on 29.07.2021.
//

import Foundation
import EasyDi


class RegisterClientViewAssmebly: Assembly {
    var registerClientView: RegisterClientViewProtocol {
        define(init: RegisterClientViewImpl()) {
            return $0
        }
    }
}
