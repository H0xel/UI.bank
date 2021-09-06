//
//  TransactionPResenter.swift
//  UIBank
//
//  Created by Ivan Amakhin on 13.08.2021.
//

import Foundation
import PhoneNumberKit
import Combine

protocol TransactionPresenter {
    func sendMoneyButtonTapped()
    func addMoneyButtonButtonTapped()
    func createDepositButtonTapped()
    func viewLoaded()
    func showCurrency()
}

class TransactionPresenterImpl: TransactionPresenter {
    
    weak var view: TransactionPresenterView?
    
    var bank: Bank!
    var fastPaymentService: FastPaymentsService!
    var moneyService: MoneyService!
    var rateService: RateService!
    let phoneNumberKit = PhoneNumberKit()
    var cancellable: AnyCancellable?
    
    func viewLoaded() {
        view?.pickerState = PickerState(components: [ComponentItem(currency: "RUB"), ComponentItem(currency: "USD")])
    }
    
    func showCurrency() {
        let fromCurrencyId = view?.pickerState?.components?[view?.transactionViewState?.fromCurrencyIndex ?? 0].currency ?? ""
        let toCurrnecyId = view?.pickerState?.components?[view?.transactionViewState?.toCurrencyIndex ?? 0].currency ?? ""
        
        cancellable = rateService
            .load(from: fromCurrencyId,
                  to: toCurrnecyId)
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: {_ in}) { [weak self] in
                        self?.view?.display(currency: String($0[fromCurrencyId + "_" + toCurrnecyId] ?? 0))
        }
    }
    
    func addMoneyButtonButtonTapped() {
        
        showCurrency()
        
        guard let addSumm = view?.transactionViewState?.addSummToDeposit,
              let addMoneyPhone = view?.transactionViewState?.addMoneyToNumberPhone
        else { return }
        
        do {
            let addMoneyNumber = try phoneNumberKit.parse("\(addMoneyPhone)")
            let addMoneyCountryCode = addMoneyNumber.countryCode
            let addMoneyNumberBody = addMoneyNumber.nationalNumber
            
            try moneyService.recieve(summ: Float(addSumm) ?? 0,
                                                      phone: Phone(countryCode: Int(addMoneyCountryCode),
                                                                   numberPhone: Int(addMoneyNumberBody)))
            
            try moneyService.printProduct(phone: Phone(countryCode: Int(addMoneyCountryCode),
                                                                    numberPhone: Int(addMoneyNumberBody)))
            print("Money added to \(addMoneyPhone)")
        } catch {
            print("Invalid phonenumber")
        }
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

                        try fastPaymentService.send(from: Phone(countryCode: Int(senderCountryCode),
                                                                                 numberPhone: Int(senderNumberBody)),
                                                                     summ: Float(summ) ?? 0,
                                                                     to: Phone(countryCode: Int(receiverCountryCode),
                                                                               numberPhone: Int(receiverNumberBody)))
                        print("Money send from \(senderPhone)")
                        try moneyService.printProduct(phone: Phone(countryCode: Int(senderCountryCode),
                                                                                numberPhone: Int(senderNumberBody)))
                        
                        print("Money received by \(receiverPhone)")
                        try moneyService.printProduct(phone: Phone(countryCode: Int(receiverCountryCode),
                                                                                numberPhone: Int(receiverNumberBody)))
        } catch {
            print("Generic parser error")
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
