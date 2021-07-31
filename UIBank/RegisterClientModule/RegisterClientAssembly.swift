//
//  RegisteClientAssembly.swift
//  UIBank
//
//  Created by Ivan Amakhin on 20.07.2021.
//

import EasyDi

class RegisterClientAseembly: Assembly {
    
//    private lazy var bankAssembly: BankAssembly = context.assembly()
    private lazy var registerPresenter: RegisterClientPresenterAssembly = context.assembly()
    
    var viewcontroller: RegisterClientController {
        define(init: (ViewControllersFactory().viewController(identifier: "RegisterClientController")) as RegisterClientController) {
//            $0.bank = self.bankAssembly.bank
            $0.presenter = self.registerPresenter.registerClientPresenter
            return $0
        }
    }
}
