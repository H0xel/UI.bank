//
//  ProductDetailPresenter.swift
//  UIBank
//
//  Created by Ivan Amakhin on 13.08.2021.
//

import Foundation
import PhoneNumberKit
import Combine

protocol ProductDetailPresenter {
    func addMoneyToDepositButtonTapped()
    func transactionMoneyButtonTapped()
    func viewDidLoaded()
    func currencyButtonTapped()
}

class ProductDetailPresenterImpl: ProductDetailPresenter {
  
    weak var view: ProductDetailPresenterView?
    var fastPaymentService: FastPaymentsService!
    var moneyService: MoneyService!
    var rateService: RateService!
    
    var router: UserRouter!
    var user: User!
    var product: Product!
    private let formater = Formater()
    private let phoneNumberKit = PhoneNumberKit()
    
    var cancellable: AnyCancellable?
    
    func showDeposit(product: Product){
        
        let toCurrencyId = view?.pickerState?.currency[view?.productDetailViewState?.pickerIndex ?? 0].currency ?? ""
        
        switch product.type {
        
        case let .deposit(deposit):
            self.view?.display(deposit: "Депозит - \(deposit.summ)")
        
            cancellable = rateService.load(from: "RUB",
                                           to: toCurrencyId)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: {_ in}) { [weak self] in
                    
                    self?.view?.display(deposit: "Депозит - \(Double(deposit.summ) * ($0["RUB_\(toCurrencyId)"] ?? 0))  \(toCurrencyId)")
                }
            
        case let .credit(credit):
            self.view?.display(deposit: "Кредит - \(credit.summ)")
            
            cancellable = rateService.load(from: "RUB",
                                           to: toCurrencyId)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: {_ in}) { [weak self] in
                    
                    self?.view?.display(deposit: "Кредит - \(Double(credit.summ) * ($0["RUB_\(toCurrencyId)"] ?? 0))  \(toCurrencyId)")
                }
        }
    }
    
    
    
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
        view?.display(deposit: formater.format(product: product))
        view?.pickerState = PickerViewState(currency: [CurrencyItem(currency: "RUB"),
                                                       CurrencyItem(currency: "USD"),
                                                       CurrencyItem(currency: "EUR"),
                                                       CurrencyItem(currency: "BTC")])
    }
    
    func currencyButtonTapped() {
        showDeposit(product: product)
    }
}
