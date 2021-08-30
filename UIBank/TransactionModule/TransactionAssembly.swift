//
//  TransactionAssembly.swift
//  UIBank
//
//  Created by Ivan Amakhin on 20.07.2021.
//

import EasyDi

class TransactionAssembly: Assembly {
    
    private lazy var bank: BankAssembly = context.assembly()
    private lazy var services: ServicesAssembly = context.assembly()
    
    var viewcontroller: TransactionController {
        define(init: TransactionController()) {
            $0.presenter = self.presenter(view: $0)
            return $0
        }
    }
}

extension TransactionAssembly{
    
    func presenter (view: TransactionPresenterView) -> TransactionPresenterImpl {
        define(init: TransactionPresenterImpl()) {
            $0.bank = self.bank.bank
            $0.services = self.services
            $0.view = view
            return $0
        }
    }
}
