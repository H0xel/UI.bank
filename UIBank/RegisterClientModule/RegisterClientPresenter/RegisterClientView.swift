//
//  RegisterClientView.swift
//  UIBank
//
//  Created by Ivan Amakhin on 29.07.2021.
//

import Foundation
import EasyDi

protocol RegisterClientViewProtocol{
    func inputClient(name: String, secondName: String, lastName: String, email: String, phone: Phone, address: Address)
}

class RegisterClientViewImpl: RegisterClientViewProtocol {
    func inputClient(name: String, secondName: String, lastName: String, email: String, phone: Phone, address: Address) {
    }
}


