//
//  TransactionController.swift
//  UIBank
//
//  Created by Ivan Amakhin on 20.07.2021.
//

import UIKit
import PhoneNumberKit

struct TransactionViewState {
    let depositNumberPhone: String?
    let addMoneyToNumberPhone: String?
    let addSummToDeposit: String?
    let senderMoney: String?
    let receiverMoney: String?
    let transactionSumm: String?
}


protocol TransactionPresenterView: AnyObject {
    var transactionViewState: TransactionViewState? { get }
    func display()
}


class TransactionController: UIViewController{
    
    var presenter: TransactionPresenterImpl!
    
    @IBOutlet weak var depositNumberPhoneTextField: PhoneNumberTextField!
    @IBOutlet weak var addMoneyToNumberPhoneTextField: PhoneNumberTextField!
    @IBOutlet weak var addSummToDepositTextField: UITextField!
    @IBOutlet weak var senderMoneyTextField: PhoneNumberTextField!
    @IBOutlet weak var receiverMoneyTextField: PhoneNumberTextField!
    @IBOutlet weak var transactionSummTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewLoaded()
        
    }
    
    @IBAction func sendMoney() {
        view.endEditing(true)
        presenter.sendMoneyButtonTapped()
    }
    
    
    @IBAction func addMoneyButton() {
        presenter.addMoneyButtonButtonTapped()
    }
    
    @IBAction func createDeposit() {
        presenter.createDepositButtonTapped()
    }
}

extension TransactionController: TransactionPresenterView {
    var transactionViewState: TransactionViewState? {
        TransactionViewState(depositNumberPhone: depositNumberPhoneTextField.text,
                             addMoneyToNumberPhone: addMoneyToNumberPhoneTextField.text,
                             addSummToDeposit: addSummToDepositTextField.text,
                             senderMoney: senderMoneyTextField.text,
                             receiverMoney: receiverMoneyTextField.text,
                             transactionSumm: transactionSummTextField.text)
    }
    func display() {
        depositNumberPhoneTextField.placeholder = "Введи номер чтобы создать депозит"
        depositNumberPhoneTextField.withFlag = true
        addMoneyToNumberPhoneTextField.placeholder = "Номер телефона для добавления денег на счет"
        addMoneyToNumberPhoneTextField.withFlag = true
        senderMoneyTextField.placeholder = "Отправитель"
        senderMoneyTextField.withFlag = true
        receiverMoneyTextField.placeholder = "Получатель"
        receiverMoneyTextField.withFlag = true
        transactionSummTextField.placeholder = "Сумма"
    }
}
