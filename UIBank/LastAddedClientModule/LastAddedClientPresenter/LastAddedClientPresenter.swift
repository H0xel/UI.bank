//
//  LastAddedClientPresenter.swift
//  UIBank
//
//  Created by Ivan Amakhin on 29.07.2021.
//

import Foundation

protocol LastAddedClientPresenterProtocol {
    func showLastClient()
}

class lastAddedClientPresenterImpl: LastAddedClientPresenterProtocol {
    
    var view: LastAddedClientViewProtocol!
    var bank: Bank!
    
    func showLastClient() {
        
        guard let lastClient = bank.users().last else { return }
        
        let formater = Formater()
        
        view.setClient(fullname: formater.format(fullname: lastClient),
                            email: lastClient.email,
                            phone: formater.format(phone: lastClient.phone),
                            adress: formater.format(adress: lastClient.address))
    }
}
