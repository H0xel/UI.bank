//
//  TransactionPResenterAseembly.swift
//  UIBank
//
//  Created by Ivan Amakhin on 13.08.2021.
//

import EasyDi

class TransactionPresenterAssembly: Assembly {
    
    private lazy var bank: BankAssembly = context.assembly()
    private lazy var services: ServicesAssembly = context.assembly()
    
    func TransactionPresenterAssembly(view: TransactionPresenterView) -> TransactionPresenterImpl {
        define(init: TransactionPresenterImpl()) {
            $0.bank = self.bank.bank
            $0.services = self.services
            $0.view = view
            return $0
        }
    }
}
