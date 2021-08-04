//
//  LastAddedClientPresenterAssembly.swift
//  UIBank
//
//  Created by Ivan Amakhin on 29.07.2021.
//

import Foundation
import EasyDi

class LastAddedClientPresenterAssembly: Assembly {
    private lazy var lastAddedClientViewAssembly: LastAddedClientViewAssembly = context.assembly()
    private lazy var bankAssembly: BankAssembly = context.assembly()
    
//    var lastAddedClientPresenter: lastAddedClientPresenterImpl {
//        define(init: lastAddedClientPresenterImpl()){
//            $0.view = self.lastAddedClientViewAssembly.lastAddedClient
//            $0.bank = self.bankAssembly.bank
//            return $0
//        }
//    }
    
    func lastAddedClientPresenter(view: LastAddedClientViewProtocol) -> lastAddedClientPresenterImpl {
        define(init: lastAddedClientPresenterImpl()) {
            $0.view = view
            $0.bank = self.bankAssembly.bank
            return $0
        }
    }
}

/*
 в ассембли $0.presenter = self.lastAddedClientPresenterAssembly.lastAddedClientPresenter
 так делать не надо, лучше lastAddedClientPresenter сделать функцией
 и подавать ей на вход вью контроллер, который будет $0 в инжект замыкании
 */
