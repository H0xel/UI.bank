//
//  ShowClientPresenter.swift
//  UIBank
//
//  Created by Ivan Amakhin on 10.08.2021.
//

import Foundation

protocol ShowClientPresenter {
    func viewWillAppeared()
    func cellTapped(indexPath: IndexPath)
}

class ShowClientPresenterImpl: ShowClientPresenter {
    
    weak var view: ShowClientsView?
    
    var bank: Bank!
    var router: UserRouter!
    
    func cellTapped(indexPath: IndexPath) {
        let user = bank.users()[indexPath.row]
        router.userDetails(user: user)
    }
    
    func viewWillAppeared() {
        let users = bank.users()
        view?.currentState = ShowClientState(clients: users.map { ShowClientItem(fullname: $0.name + " " + $0.lastName)
        })
    }
}
