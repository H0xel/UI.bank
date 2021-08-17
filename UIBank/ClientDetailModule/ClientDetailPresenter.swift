//
//  ClientDetailPresenter.swift
//  UIBank
//
//  Created by Ivan Amakhin on 13.08.2021.
//

import Foundation

protocol ClientDetailPresenter {
    func createDepositButtonTapped()
    func cellTapped(indexPath: IndexPath)
    func viewWillAppeared()
}

class ClientDetailPresenterImpl: ClientDetailPresenter {
    
    weak var view: ClientPresenterView?
    var bank: Bank!
    var user: User!
    var userProducts: [Product]!
    var router: UserRouter!
    private let formater = Formater()
    
    func createDepositButtonTapped() {
        let product = bank.createDepositProduct(user: user)
        router.productDetails(user: user, product: product)
        print(product)
    }
    
    func viewWillAppeared() {
        
        view?.displayLabels(fullname: formater.format(fullname: user),
                      phoneNumber: formater.format(phone: user.phone),
                      email: user.email,
                      adress: formater.format(adress: user.address))
        view?.currentState = ClientDetailState(products: userProducts.map{ ProductItem(productName: $0.name + " " + $0.id, prodyctType: formater.format(product: $0)) })
    }
    
    func cellTapped(indexPath: IndexPath) {
        let product = bank.products(user: user)[indexPath.row]
        router.productDetails(user: user, product: product)
    }
}
