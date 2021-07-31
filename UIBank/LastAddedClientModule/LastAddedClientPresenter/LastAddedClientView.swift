//
//  LastAddedClientView.swift
//  UIBank
//
//  Created by Ivan Amakhin on 29.07.2021.
//

import Foundation

protocol LastAddedClientViewProtocol {
    func setClient(fullname: String, email: String, phone: String, adress: String)
}

class LastAddedClientViewImpl: LastAddedClientViewProtocol {
    func setClient(fullname: String, email: String, phone: String, adress: String) {
    }
}
