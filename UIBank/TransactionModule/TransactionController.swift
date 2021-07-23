//
//  TransactionController.swift
//  UIBank
//
//  Created by Ivan Amakhin on 20.07.2021.
//

import UIKit
import PhoneNumberKit

class TransactionController: UIViewController, UITextFieldDelegate{
    
    var bankAssembly: BankAssembly!
    var storageAssembly: StoragesAssembly!
    var servicesAssembly: ServicesAssembly!
    var phoneNumberKit = PhoneNumberKit()
    
    @IBOutlet weak var depositNumberPhoneTextField: PhoneNumberTextField!
    @IBOutlet weak var senderMoneyTextField: PhoneNumberTextField!
    @IBOutlet weak var moneySummTextField: UITextField!
    @IBOutlet weak var receiverMoneyTextField: PhoneNumberTextField!
    @IBOutlet weak var addMoneyTextField: PhoneNumberTextField!
    @IBOutlet weak var addMoneyField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        depositNumberPhoneTextField.placeholder = "Введи номер чтобы создать депозит"
        depositNumberPhoneTextField.withFlag = true
        addMoneyTextField.placeholder = "Номер телефона для добавления денег на счет"
        addMoneyTextField.withFlag = true
        senderMoneyTextField.placeholder = "Отправитель"
        senderMoneyTextField.withFlag = true
        receiverMoneyTextField.placeholder = "Получатель"
        receiverMoneyTextField.withFlag = true
        moneySummTextField.placeholder = "Сумма"
    }
    
    @IBAction func sendMoney() {
        view.endEditing(true)
        
        let alert = UIAlertController(title: "", message: "Вы не ввели номер телефона.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: nil))
        
        let senderPhone = senderMoneyTextField.text ?? ""
        let receiverPhone = receiverMoneyTextField.text ?? ""
        let summ = moneySummTextField.text ?? ""
        
        do {
            let senderNumber = try phoneNumberKit.parse("\(senderPhone)")
            let senderCountryCode = senderNumber.countryCode
            let senderNumberBody = senderNumber.nationalNumber
            
            let receiverNumber = try phoneNumberKit.parse("\(receiverPhone)")
            let receiverCountryCode = receiverNumber.countryCode
            let receiverNumberBody = receiverNumber.nationalNumber
            
            if senderPhone == "" || receiverPhone == "" {
                self.present(alert, animated: true, completion: nil)
                    } else {

                        try servicesAssembly.fastPaymentService.send(from: Phone(countryCode: Int(senderCountryCode),
                                                                                 numberPhone: Int(senderNumberBody)),
                                                                     summ: Float(summ) ?? 0,
                                                                     to: Phone(countryCode: Int(receiverCountryCode),
                                                                               numberPhone: Int(receiverNumberBody)))
                        print("Money send from \(senderPhone)")
                        try servicesAssembly.MoneyService.printProduct(phone: Phone(countryCode: Int(senderCountryCode),
                                                                                numberPhone: Int(senderNumberBody)))
                        
                        print("Money received by \(receiverPhone)")
                        try servicesAssembly.MoneyService.printProduct(phone: Phone(countryCode: Int(receiverCountryCode),
                                                                                numberPhone: Int(receiverNumberBody)))
            }
        } catch {
            print("Generic parser error")
        }
    }
    
    
    @IBAction func addMoneyButton() {
        let addSumm = addMoneyField.text ?? ""
        let addMoneyPhone = addMoneyTextField.text ?? ""
        
        do {
            let addMoneyNumber = try phoneNumberKit.parse("\(addMoneyPhone)")
            let addMoneyCountryCode = addMoneyNumber.countryCode
            let addMoneyNumberBody = addMoneyNumber.nationalNumber
            
            try servicesAssembly.MoneyService.recieve(summ: Float(addSumm) ?? 0,
                                                      phone: Phone(countryCode: Int(addMoneyCountryCode),
                                                                   numberPhone: Int(addMoneyNumberBody)))
            
            try servicesAssembly.MoneyService.printProduct(phone: Phone(countryCode: Int(addMoneyCountryCode),
                                                                    numberPhone: Int(addMoneyNumberBody)))
            print("Money added to \(addMoneyPhone)")
        } catch {
            print("Invalid phonenumber")
        }
    }
    
    @IBAction func createDeposit() {
        let depositPhone = depositNumberPhoneTextField.text ?? ""
        
        do {
            let depositNumber = try phoneNumberKit.parse("\(depositPhone)")
            let depositCountryCode = depositNumber.countryCode
            let depositNumberBody = depositNumber.nationalNumber
            let client = try storageAssembly.userStorage.search(phone: Phone(countryCode: Int(depositCountryCode),
                                                                     numberPhone: Int(depositNumberBody)))
            let product = bankAssembly.bank.createDepositProduct(user: client)
            print(product)
        } catch {
            print("Error creating deposit")
        }
    }
}
