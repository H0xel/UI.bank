//
//  TableViewAssembly.swift
//  UIBank
//
//  Created by Ivan Amakhin on 20.07.2021.
//

import EasyDi

class ShowClientsAssembly: Assembly {
    private lazy var bank: BankAssembly = context.assembly()
    private lazy var router: UserRouterAssembly = context.assembly()

    var tableViewController: ShowClientsController {
        define(init: ShowClientsController()) {
            $0.presenter = self.presenter(view: $0, viewcontroller: $0)
            return $0
        }
    }
}

extension ShowClientsAssembly{
    
    func presenter(view: ShowClientsView, viewcontroller: UIViewController) -> ShowClientPresenter {
        define(init: ShowClientPresenterImpl()) {
            $0.view = view
            $0.bank = self.bank.bank
            $0.router = self.router.router(viewController: viewcontroller)
            return $0
        }
    }
}
