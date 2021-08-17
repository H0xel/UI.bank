//
//  ProductDetailViewController.swift
//  UIBank
//
//  Created by Ivan Amakhin on 13.08.2021.
//

import UIKit
import PhoneNumberKit

struct ProductDetailViewState {
    var addMoneyToDeposit: String?
    var receiverPhoneNumber: String?
}

protocol ProductDetailPresenterView: AnyObject {
    var productDetailViewState: ProductDetailViewState? { get }
    func diplay(deposit: String)
}

class ProductDeatilViewController: UIViewController {
    
    var presenter: ProductDetailPresenter!
    
    @IBOutlet weak var depositAmountLabel: UILabel!
    @IBOutlet weak var addMoneyToDepositTextField: UITextField!
    @IBOutlet weak var receiverPhoneNumber: PhoneNumberTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter.viewDidLoaded()
    }
    
    @IBAction func addMoneyToDepositButton() {
        presenter.addMoneyToDepositButtonTapped()
    }
    
    @IBAction func transactionMoney() {
        presenter.transactionMoneyButtonTapped()
    }
}

extension ProductDeatilViewController: ProductDetailPresenterView {
    var productDetailViewState: ProductDetailViewState? {
        ProductDetailViewState(addMoneyToDeposit: addMoneyToDepositTextField.text,
                               receiverPhoneNumber: receiverPhoneNumber.text)
    }
    
    func diplay(deposit: String) {
        depositAmountLabel.text = deposit
        addMoneyToDepositTextField.placeholder = "Бабло"
        addMoneyToDepositTextField.keyboardType = .numberPad
        receiverPhoneNumber.placeholder = "Номер телефона"
        receiverPhoneNumber.withFlag = true
    }
}
