//
//  LastAddedClientAssembly.swift
//  UIBank
//
//  Created by Ivan Amakhin on 20.07.2021.
//

import EasyDi

class LastAddedClientAssembly: Assembly {
    
//    private lazy var bankAssembly: BankAssembly = context.assembly()
    private lazy var lastAddedClientPresenterAssembly: LastAddedClientPresenterAssembly = context.assembly()
    private lazy var lastAddedClientViewAssembly: LastAddedClientViewAssembly = context.assembly()
    
    var viewcontroller: LastAddedClientController {
        define(init: (ViewControllersFactory().viewController(identifier: "LastAddedClientController") as LastAddedClientController)) {
//            $0.bank = self.bankAssembly.bank
            $0.presenter = self.lastAddedClientPresenterAssembly.lastAddedClientPresenter(view: self.lastAddedClientViewAssembly.lastAddedClient)
            return $0
        }
    }
}



