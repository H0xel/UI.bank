//
//  CreateProductPresenter.swift
//  UIBank
//
//  Created by Ivan Amakhin on 30.08.2021.
//

import Foundation

protocol CreateProductPresenter {
    func viewLoaded()
    func createProductButtonTapped()
}

class CreateProductPresenterImpl: CreateProductPresenter {
  
    weak var view: CreateProductView?
    var router: UserRouter!
    var user: User!
    var bank: Bank!
    var moneyService: MoneyService!
    
    var result: ((Product) -> ())?
    let formater = Formater()
    
    func viewLoaded() {
        view?.display()
        view?.productPickerState = ProductPickerDetailState(productsName: ["Депозит", "Кредит"])
    }
    
    func createProductButtonTapped() {
        
        guard let sum = view?.viewState.addMoneyTextField else { return }
        
        switch view?.viewState.productIndex {
        
        case 0:
            let product = bank.createDepositProduct(user: user)
            print(product)
            do {
                try moneyService.recieve(summ: Float(sum) ?? 0, phone: user.phone)
                result?(product)
            } catch {
                print(error)
            }
            
            router.dissmiss()
            
            
        case 1:
            let product = bank.createCreditProduct(user: user)
            result?(product)
            print(product)
            router.dissmiss()
            
            
        default:
            print("No product have been added")
        }
    }
}
