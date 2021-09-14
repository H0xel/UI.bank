//
//  ClientDetailPresenter.swift
//  UIBank
//
//  Created by Ivan Amakhin on 13.08.2021.
//

import Foundation
import UIKit

protocol ClientDetailPresenter {
    func chooseProductButtonTapped()
    func cellTapped(indexPath: IndexPath)
    func viewWillAppeared()
}

class ClientDetailPresenterImpl: ClientDetailPresenter {

    
    
    weak var view: ClientPresenterView?
    var bank: Bank!
    var user: User!
    var router: UserRouter!
    var assembly: CreateProductAssembly!
    
    private let formater = Formater()
    
    func chooseProductButtonTapped() {
        let url = URL(string: "")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            self.user
        }
        
        UIView.animate(withDuration: 3) {
            self.user
        }
        
        router.createProduct(user: user) { product in
            var array = self.view?.currentState?.products ?? []
            array.append(ProductItem(productName: product.name, prodyctType: self.formater.format(product: product)))
            self.view?.currentState = ClientDetailState(products: array)
        }
    }
    
    func viewWillAppeared() {
        
        view?.displayLabels(fullname: formater.format(fullname: user),
                      phoneNumber: formater.format(phone: user.phone),
                      email: user.email,
                      adress: formater.format(adress: user.address))
        
        
        
        view?.currentState = ClientDetailState(products: bank.products(user: user)
                                                .map{ ProductItem(productName: $0.name + " " + $0.id,
                                                                  prodyctType: formater.format(product: $0)) })
        
    }
    
    func cellTapped(indexPath: IndexPath) {
        let product = bank.products(user: user)[indexPath.row]
        router.productDetails(user: user, product: product)
        }
}
