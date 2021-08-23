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
    
    let depositAmountLabel = UILabel()
    let addMoneyToDepositTextField = UITextField()
    let receiverPhoneNumber = PhoneNumberTextField()
    let addMoneyToDepositButton = UIButton()
    let transactionMoneyButton = UIButton()
    let stackVIew = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter.viewDidLoaded()
    }
    
    @objc func addMoneyToDepositButtonTap() {
        presenter.addMoneyToDepositButtonTapped()
    }
    
    @objc func transactionMoneyButtonTap() {
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
        viewsAdded()
        setupAdded()
    }
    
    func viewsAdded() {
        view.addSubview(stackVIew)
        stackVIew.addSubview(depositAmountLabel)
        stackVIew.addSubview(addMoneyToDepositTextField)
        stackVIew.addSubview(receiverPhoneNumber)
        stackVIew.addSubview(addMoneyToDepositButton)
        stackVIew.addSubview(transactionMoneyButton)
        //        stackVIew.addArrangedSubview(<#T##view: UIView##UIView#>) // зачем нужно это если можно просто добавить сабвью?
    }
    
    func setupAdded() {
        setupStackView()
        setupDepositAmountLabel()
        setupAddMoneyToDepositTextField()
        setupReceiverPhoneNumber()
        setupAddMoneyToDepositButton()
        setupTransactionMoneyButton()
    }
    
    func setupStackView() {
        stackVIew.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackVIew.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            stackVIew.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            stackVIew.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            stackVIew.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    func setupDepositAmountLabel() {
        depositAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        depositAmountLabel.font = UIFont.boldSystemFont(ofSize: 14)
        
        NSLayoutConstraint.activate([
            depositAmountLabel.topAnchor.constraint(equalTo: stackVIew.topAnchor),
            depositAmountLabel.leftAnchor.constraint(equalTo: stackVIew.leftAnchor),
            depositAmountLabel.widthAnchor.constraint(equalTo: self.depositAmountLabel.widthAnchor),
            depositAmountLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 34)
        ])
    }
    
    func setupAddMoneyToDepositButton() {
        addMoneyToDepositButton.translatesAutoresizingMaskIntoConstraints = false
        addMoneyToDepositButton.addTarget(self, action: #selector(addMoneyToDepositButtonTap), for: .touchUpInside)
        addMoneyToDepositButton.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        addMoneyToDepositButton.translatesAutoresizingMaskIntoConstraints = false
        addMoneyToDepositButton.setTitle("Добавить", for: .normal)
        addMoneyToDepositButton.setTitleColor(.blue, for: .normal)
        addMoneyToDepositButton.titleLabel?.textAlignment = .center
        addMoneyToDepositButton.layer.borderWidth = 2
        addMoneyToDepositButton.layer.borderColor = UIColor.blue.cgColor
        addMoneyToDepositButton.layer.cornerRadius = 5.0
        
        NSLayoutConstraint.activate([
            addMoneyToDepositButton.topAnchor.constraint(equalTo: depositAmountLabel.bottomAnchor, constant: 20),
            addMoneyToDepositButton.leftAnchor.constraint(equalTo: stackVIew.leftAnchor),
            addMoneyToDepositButton.widthAnchor.constraint(lessThanOrEqualTo: stackVIew.widthAnchor, multiplier: 1/3),
            addMoneyToDepositButton.heightAnchor.constraint(equalTo: depositAmountLabel.heightAnchor)
        ])
    }
    
    func setupAddMoneyToDepositTextField() {
        addMoneyToDepositTextField.translatesAutoresizingMaskIntoConstraints = false
        addMoneyToDepositTextField.textOptions(placeholder: "Бабло")
        addMoneyToDepositTextField.keyboardType = .numberPad
        
        NSLayoutConstraint.activate([
            addMoneyToDepositTextField.topAnchor.constraint(equalTo: addMoneyToDepositButton.topAnchor),
            addMoneyToDepositTextField.leftAnchor.constraint(equalTo: addMoneyToDepositButton.rightAnchor, constant: 20),
            addMoneyToDepositTextField.widthAnchor.constraint(equalTo: addMoneyToDepositButton.widthAnchor),
            addMoneyToDepositTextField.heightAnchor.constraint(equalTo: depositAmountLabel.heightAnchor)
        ])
    }
    
    func setupTransactionMoneyButton() {
        transactionMoneyButton.translatesAutoresizingMaskIntoConstraints = false
        transactionMoneyButton.addTarget(self, action: #selector(transactionMoneyButtonTap), for: .touchUpInside)
        transactionMoneyButton.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        transactionMoneyButton.translatesAutoresizingMaskIntoConstraints = false
        transactionMoneyButton.setTitle("Перевести", for: .normal)
        transactionMoneyButton.setTitleColor(.blue, for: .normal)
        transactionMoneyButton.titleLabel?.textAlignment = .center
        transactionMoneyButton.layer.borderWidth = 2
        transactionMoneyButton.layer.borderColor = UIColor.blue.cgColor
        transactionMoneyButton.layer.cornerRadius = 5.0
        
        NSLayoutConstraint.activate([
            transactionMoneyButton.topAnchor.constraint(equalTo: addMoneyToDepositButton.topAnchor),
            transactionMoneyButton.leftAnchor.constraint(equalTo: addMoneyToDepositTextField.rightAnchor, constant: 20),
            transactionMoneyButton.rightAnchor.constraint(equalTo: stackVIew.rightAnchor),
            transactionMoneyButton.widthAnchor.constraint(equalTo: addMoneyToDepositButton.widthAnchor),
            transactionMoneyButton.heightAnchor.constraint(equalTo: depositAmountLabel.heightAnchor)
        ])
        
    }
    
    func setupReceiverPhoneNumber() {
        receiverPhoneNumber.translatesAutoresizingMaskIntoConstraints = false
        receiverPhoneNumber.textOptions(placeholder: "Номер телефона")
        receiverPhoneNumber.withFlag = true
        
        NSLayoutConstraint.activate([
            receiverPhoneNumber.topAnchor.constraint(equalTo: transactionMoneyButton.bottomAnchor, constant: 20),
            receiverPhoneNumber.leftAnchor.constraint(equalTo: stackVIew.leftAnchor),
            receiverPhoneNumber.rightAnchor.constraint(equalTo: stackVIew.rightAnchor),
            receiverPhoneNumber.widthAnchor.constraint(equalTo: stackVIew.widthAnchor),
            receiverPhoneNumber.heightAnchor.constraint(equalTo: depositAmountLabel.heightAnchor)
        ])
    }
}
