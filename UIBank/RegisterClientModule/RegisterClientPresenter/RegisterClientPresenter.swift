//
//  MainPresenter.swift
//  UIBank
//
//  Created by Ivan Amakhin on 27.07.2021.
//

import Foundation
import EasyDi
import PhoneNumberKit



protocol RegisterClientViewPresenterProtocol{
//    init(view: RegisterClientViewProtocol, bank: Bank)
    func registerClient(name: String, secondName: String, lastName: String, email: String, phone: Phone, address: Address) -> User
}

class RegisterClientPresenterImpl: RegisterClientViewPresenterProtocol {
    

    var view: RegisterClientViewProtocol!
    var bank: Bank!
    let phoneNumberKit = PhoneNumberKit()
    let formater = Formater()
    
//    required init(view: RegisterClientViewProtocol, bank: Bank) {
//        self.view = view
//        self.bank = bank
//    }
    
    func registerClient(name: String, secondName: String, lastName: String, email: String, phone: Phone, address: Address) -> User {
        
        let client = bank.createClient(name: name, secondName: secondName, lastName: lastName, email: email, phone: phone, address: address)
        
        self.view.inputClient(name: client.name, secondName: client.secondName, lastName: client.lastName, email: client.email, phone: client.phone, address: client.address)
        
        return client
    }
}
