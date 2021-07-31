//
//  TransactionAssembly.swift
//  UIBank
//
//  Created by Ivan Amakhin on 20.07.2021.
//

import EasyDi

class TransactionAssembly: Assembly {
    
    private lazy var bankAssembly: BankAssembly = context.assembly()
    private lazy var storagesAssembly: StoragesAssembly = context.assembly()
    private lazy var servicesAssembly: ServicesAssembly = context.assembly()
    
    var viewcontroller: TransactionController {
        define(init: (ViewControllersFactory().viewController(identifier: "TransactionController") as TransactionController)) {
            $0.bank = self.bankAssembly.bank
            $0.servicesAssembly = self.servicesAssembly
            return $0
        }
    }
}
