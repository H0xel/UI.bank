//
//  ProductDetailPresenter.swift
//  UIBank
//
//  Created by Ivan Amakhin on 13.08.2021.
//

import Foundation
import PhoneNumberKit

protocol ProductDetailPresenter {
    func addMoneyToDepositButtonTapped()
    func transactionMoneyButtonTapped()
    func viewDidLoaded()
}

class ProductDetailPresenterImpl: ProductDetailPresenter {
  
    weak var view: ProductDetailPresenterView?
    var fastPaymentService: FastPaymentsService!
    var moneyService: MoneyService!
    var router: UserRouter!
    var user: User!
    var product: Product!
    private let formater = Formater()
    private let phoneNumberKit = PhoneNumberKit()
    
    
    func addMoneyToDepositButtonTapped() {
        guard let summ = view?.productDetailViewState?.addMoneyToDeposit else { return }
        do {
            try moneyService.recieve(summ: Float(summ) ?? 0, phone: user.phone)
        } catch {
            print("money didnt added")
        }
    }
    
    func transactionMoneyButtonTapped() {
        guard let phoneNumber = view?.productDetailViewState?.receiverPhoneNumber,
        let summ = view?.productDetailViewState?.addMoneyToDeposit
        else {return}
        
        do {
            let number = try phoneNumberKit.parse(phoneNumber)
            let codeNumber = number.countryCode
            let bodyNumber = number.nationalNumber
            try fastPaymentService.send(from: user.phone,
                                        summ: Float(summ) ?? 0,
                                        to: Phone(countryCode: Int(codeNumber),
                                                  numberPhone: Int(bodyNumber)))
            
        } catch {
            print("Generic parser error")
        }
    }
    
    func viewDidLoaded() {
        view?.diplay(deposit: formater.format(product: product))
    }
}
