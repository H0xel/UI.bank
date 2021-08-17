//
//  LastAddedClientPresenter.swift
//  UIBank
//
//  Created by Ivan Amakhin on 29.07.2021.
//

import Foundation

protocol LastAddedClientPresenter {
    func viweWillAppeared()
}

class lastAddedClientPresenterImpl: LastAddedClientPresenter {
    
    weak var view: LastAddedClientView?
    var bank: Bank!
    
    func viweWillAppeared() {
        
        guard let lastClient = bank.users().last else { return }
        let formater = Formater()
        view?.display(fullname: formater.format(fullname: lastClient),
                            email: lastClient.email,
                            phone: formater.format(phone: lastClient.phone),
                            adress: formater.format(adress: lastClient.address))
    }
}
