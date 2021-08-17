//
//  TransactionPResenter.swift
//  UIBank
//
//  Created by Ivan Amakhin on 13.08.2021.
//

import Foundation
import PhoneNumberKit

protocol TransactionPresenter {
    func sendMoneyButtonTapped()
    func addMoneyButtonButtonTapped()
    func createDepositButtonTapped()
    func viewLoaded()
}

class TransactionPresenterImpl: TransactionPresenter {
    
    
    weak var view: TransactionPresenterView?
    var bank: Bank!
    var services: ServicesAssembly!
    let phoneNumberKit = PhoneNumberKit()
    
    
    func viewLoaded() {
        view?.display()
    }
    
    func sendMoneyButtonTapped() {
        
        guard let senderPhone = view?.transactionViewState?.senderMoney,
              let receiverPhone = view?.transactionViewState?.receiverMoney,
              let summ = view?.transactionViewState?.transactionSumm
        else { return }
        
        
        do {
            let senderNumber = try phoneNumberKit.parse("\(senderPhone)")
            let senderCountryCode = senderNumber.countryCode
            let senderNumberBody = senderNumber.nationalNumber
            
            let receiverNumber = try phoneNumberKit.parse("\(receiverPhone)")
            let receiverCountryCode = receiverNumber.countryCode
            let receiverNumberBody = receiverNumber.nationalNumber

                        try services.fastPaymentService.send(from: Phone(countryCode: Int(senderCountryCode),
                                                                                 numberPhone: Int(senderNumberBody)),
                                                                     summ: Float(summ) ?? 0,
                                                                     to: Phone(countryCode: Int(receiverCountryCode),
                                                                               numberPhone: Int(receiverNumberBody)))
                        print("Money send from \(senderPhone)")
                        try services.MoneyService.printProduct(phone: Phone(countryCode: Int(senderCountryCode),
                                                                                numberPhone: Int(senderNumberBody)))
                        
                        print("Money received by \(receiverPhone)")
                        try services.MoneyService.printProduct(phone: Phone(countryCode: Int(receiverCountryCode),
                                                                                numberPhone: Int(receiverNumberBody)))
        } catch {
            print("Generic parser error")
        }
    }
    
    func addMoneyButtonButtonTapped() {
        
        guard let addSumm = view?.transactionViewState?.addSummToDeposit,
              let addMoneyPhone = view?.transactionViewState?.addMoneyToNumberPhone
        else { return }
        
        do {
            let addMoneyNumber = try phoneNumberKit.parse("\(addMoneyPhone)")
            let addMoneyCountryCode = addMoneyNumber.countryCode
            let addMoneyNumberBody = addMoneyNumber.nationalNumber
            
            try services.MoneyService.recieve(summ: Float(addSumm) ?? 0,
                                                      phone: Phone(countryCode: Int(addMoneyCountryCode),
                                                                   numberPhone: Int(addMoneyNumberBody)))
            
            try services.MoneyService.printProduct(phone: Phone(countryCode: Int(addMoneyCountryCode),
                                                                    numberPhone: Int(addMoneyNumberBody)))
            print("Money added to \(addMoneyPhone)")
        } catch {
            print("Invalid phonenumber")
        }
    }
    
    func createDepositButtonTapped() {
        
        guard let depositPhone = view?.transactionViewState?.depositNumberPhone else { return }
        
        do {
            let depositNumber = try phoneNumberKit.parse("\(depositPhone)")
            let depositCountryCode = depositNumber.countryCode
            let depositNumberBody = depositNumber.nationalNumber
            let client = try bank.search(phone: Phone(countryCode: Int(depositCountryCode),
                                                                     numberPhone: Int(depositNumberBody)))
            let product = bank.createDepositProduct(user: client)
            print(product)
        } catch {
            print("Error creating deposit")
        }
    }
}
