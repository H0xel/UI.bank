//
//  LastAddedClientViewAssembly.swift
//  UIBank
//
//  Created by Ivan Amakhin on 29.07.2021.
//

import Foundation
import EasyDi

class LastAddedClientViewAssembly: Assembly {
    var lastAddedClient: LastAddedClientViewProtocol {
        define(init: LastAddedClientViewImpl()) {
            return $0
        }
    }
}
