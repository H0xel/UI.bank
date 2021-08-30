//
//  RegisteClientAssembly.swift
//  UIBank
//
//  Created by Ivan Amakhin on 20.07.2021.
//

import EasyDi

class RegisterClientAseembly: Assembly {
    private lazy var bankAssembly: BankAssembly = context.assembly()
    
    var viewcontroller: RegisterClientController {
        define(init: RegisterClientController()) {
            $0.presenter = self.presenter(view: $0)
            return $0
        }
    }
}

extension RegisterClientAseembly {
    
    func presenter(view: RegisterClientView) -> RegisterClientPresenter {
        define(init: RegisterClientPresenterImpl()) {
            $0.view = view
            $0.bank = self.bankAssembly.bank
            return $0
        }
    }
}
