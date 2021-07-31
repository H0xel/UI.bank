//
//  RegisterClientPresenterAssembly.swift
//  UIBank
//
//  Created by Ivan Amakhin on 28.07.2021.
//

import EasyDi

class RegisterClientPresenterAssembly: Assembly {
    
    private lazy var bankAssembly: BankAssembly = context.assembly()
    private lazy var view: RegisterClientViewAssmebly = context.assembly()
    
    var registerClientPresenter: RegisterClientPresenterImpl { // вопрос, как заинжектить formater и phonenumberkit чтобы вьюконтроллер реализовывал протокол RegisterCLientControllerProtocol
        define(init: RegisterClientPresenterImpl()) {
            $0.bank = self.bankAssembly.bank
            $0.view = self.view.registerClientView
            return $0
        }
    }
}
