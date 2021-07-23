//
//  RegisteClientAssembly.swift
//  UIBank
//
//  Created by Ivan Amakhin on 20.07.2021.
//

import EasyDi

class RegisterClientAseembly: Assembly {
    var viewcontroller: RegisterClientController {
        define(init: (ViewControllersFactory().viewController(identifier: "RegisterClientController"))) {
            return $0
        }
    }
}
