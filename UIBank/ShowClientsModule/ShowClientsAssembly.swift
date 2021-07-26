//
//  TableViewAssembly.swift
//  UIBank
//
//  Created by Ivan Amakhin on 20.07.2021.
//

import EasyDi

class ShowClientsAssembly: Assembly {
    
    private lazy var clientAssembly: ClientDetailModuleAssembly = context.assembly()
    private lazy var bank: BankAssembly = context.assembly()


    var tableViewController: ShowClientsController {
        define(init: (ViewControllersFactory().tableViewController(identifier: "ShowClientsController") as ShowClientsController)) {
            $0.clientAssembly = self.clientAssembly
//            $0.clients = self.bank.bank.users()
            return $0
        }
    }
}
