//
//  ProductDetailViewController.swift
//  UIBank
//
//  Created by Ivan Amakhin on 13.08.2021.
//

import UIKit
import PhoneNumberKit

struct CurrencyItem {
    var currency: String
}

struct PickerViewState {
    var currency: [CurrencyItem]
}

struct ProductDetailViewState {
    var addMoneyToDeposit: String?
    var receiverPhoneNumber: String?
    var pickerIndex: Int?
}

protocol ProductDetailPresenterView: AnyObject {
    var productDetailViewState: ProductDetailViewState? { get }
    var pickerState: PickerViewState? { get set }
    func display(deposit: String)
}

class ProductDeatilViewController: UIViewController {
    
    var pickerState: PickerViewState? {
        
        didSet {
            currencyPicker.reloadAllComponents()
            }
        }
    
    var presenter: ProductDetailPresenter!
    
    let depositAmountLabel = UILabel()
    let addMoneyToDepositTextField = UITextField()
    let receiverPhoneNumber = PhoneNumberTextField()
    let addMoneyToDepositButton = UIButton()
    let transactionMoneyButton = UIButton()
    let currencyPicker = UIPickerView()
    let currnecyButton = UIButton()
    let stackView = UIStackView()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
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
    
    @objc func showInCurrency() {
        presenter.currencyButtonTapped()
    }
}

extension ProductDeatilViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerState?.currency.count ?? 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerState?.currency[row].currency
    }
}

extension ProductDeatilViewController: ProductDetailPresenterView {
   
    
    var productDetailViewState: ProductDetailViewState? {
        ProductDetailViewState(addMoneyToDeposit: addMoneyToDepositTextField.text,
                               receiverPhoneNumber: receiverPhoneNumber.text,
                               pickerIndex: currencyPicker.selectedRow(inComponent: 0))
    }
    
    func display(deposit: String) {
        depositAmountLabel.text = deposit
        viewsAdded()
        setupAdded()
    }
    
    func viewsAdded() {
        view.addSubview(stackView)
        stackView.addSubview(depositAmountLabel)
        stackView.addSubview(addMoneyToDepositTextField)
        stackView.addSubview(receiverPhoneNumber)
        stackView.addSubview(addMoneyToDepositButton)
        stackView.addSubview(transactionMoneyButton)
        stackView.addSubview(currencyPicker)
        stackView.addSubview(currnecyButton)
    }
    
    func setupAdded() {
        setupstackView()
        setupDepositAmountLabel()
        setupAddMoneyToDepositTextField()
        setupReceiverPhoneNumber()
        setupAddMoneyToDepositButton()
        setupTransactionMoneyButton()
        setupPickerCurrency()
        setupCurrencyButton()
    }
    
    func setupstackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            stackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
    }
    
    func setupDepositAmountLabel() {
        depositAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        depositAmountLabel.font = UIFont.boldSystemFont(ofSize: 14)
        
        NSLayoutConstraint.activate([
            depositAmountLabel.topAnchor.constraint(equalTo: stackView.topAnchor),
            depositAmountLabel.leftAnchor.constraint(equalTo: stackView.leftAnchor),
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
            addMoneyToDepositButton.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            addMoneyToDepositButton.widthAnchor.constraint(lessThanOrEqualTo: stackView.widthAnchor, multiplier: 1/3),
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
            transactionMoneyButton.rightAnchor.constraint(equalTo: stackView.rightAnchor),
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
            receiverPhoneNumber.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            receiverPhoneNumber.rightAnchor.constraint(equalTo: stackView.rightAnchor),
            receiverPhoneNumber.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            receiverPhoneNumber.heightAnchor.constraint(equalTo: depositAmountLabel.heightAnchor)
        ])
    }
    
    func setupPickerCurrency() {
        currencyPicker.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            currencyPicker.topAnchor.constraint(equalTo: receiverPhoneNumber.bottomAnchor, constant: 20),
            currencyPicker.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            currencyPicker.rightAnchor.constraint(equalTo: stackView.rightAnchor)
        ])
    }
    
    func setupCurrencyButton() {
        currnecyButton.translatesAutoresizingMaskIntoConstraints = false
        currnecyButton.addTarget(self, action: #selector(showInCurrency), for: .touchUpInside)
        currnecyButton.setTitle("Отобразить счет в валюте", for: .normal)
        currnecyButton.setTitleColor(.blue, for: .normal)
        currnecyButton.setTitle("Отобразить счет в валюте", for: .highlighted)
        currnecyButton.setTitleColor(.lightGray, for: .highlighted)
        
        NSLayoutConstraint.activate([
            currnecyButton.topAnchor.constraint(equalTo: currencyPicker.bottomAnchor, constant: 20),
            currnecyButton.widthAnchor.constraint(equalTo: self.currnecyButton.widthAnchor),
            currnecyButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor)
        ])
    }
    
}
