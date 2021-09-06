//
//  CreateProductController.swift
//  UIBank
//
//  Created by Ivan Amakhin on 30.08.2021.
//

import UIKit
import EasyDi

struct ProductPickerItem {
    let productName: String
}

struct ProductPickerDetailState {
    let productsName: [String]
}

struct CreateProductViewState {
    let productIndex: Int
    let addMoneyTextField: String?
}

protocol CreateProductView: AnyObject {
    func display()
    var productPickerState: ProductPickerDetailState? { get set }
    var viewState: CreateProductViewState { get }
}

class CreateProductConrtoller: UIViewController {
    
    var presenter: CreateProductPresenter!
    
    var productPickerState: ProductPickerDetailState? {
        didSet {
            productPicker.reloadAllComponents()
        }
    }
    
    let createProductButton = UIButton()
    let stackView = UIStackView()
    let addMoneyToProductTextField = UITextField()
    let productPicker = UIPickerView()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productPicker.delegate = self
        productPicker.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter.viewLoaded()
    }
    
    @objc func createProductButtonTap() {
        presenter.createProductButtonTapped()
    }
    
}

extension CreateProductConrtoller: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        productPickerState?.productsName.count ?? 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        productPickerState?.productsName[row]
    }
}

extension CreateProductConrtoller: CreateProductView {
    
    var viewState: CreateProductViewState {
        CreateProductViewState(productIndex: productPicker.selectedRow(inComponent: 0),
                               addMoneyTextField: addMoneyToProductTextField.text)
    }
    
    var productIndex: Int {
        productPicker.selectedRow(inComponent: 0)
    }

    func display() {
        viewAdded()
        setupAdded()
    }
    
    func viewAdded() {
        view.addSubview(stackView)
        stackView.addSubview(productPicker)
        stackView.addSubview(addMoneyToProductTextField)
        stackView.addSubview(createProductButton)
    }
    
    func setupAdded() {
        setupStackView()
        setupProductPicker()
        setupAddMoneyToProductTextField()
        setupButton()
    }
    
    func setupStackView() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            stackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
    }
    
    func setupProductPicker() {

        productPicker.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            productPicker.topAnchor.constraint(equalTo: stackView.topAnchor),
            productPicker.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            productPicker.heightAnchor.constraint(equalTo: self.productPicker.heightAnchor)
        ])
    }
    
    func setupAddMoneyToProductTextField() {
        addMoneyToProductTextField.translatesAutoresizingMaskIntoConstraints = false
        addMoneyToProductTextField.textOptions(placeholder: "Деньги на счет")

        NSLayoutConstraint.activate([
            addMoneyToProductTextField.topAnchor.constraint(equalTo: productPicker.bottomAnchor, constant: 10),
            addMoneyToProductTextField.widthAnchor.constraint(equalTo: self.addMoneyToProductTextField.widthAnchor),
            addMoneyToProductTextField.heightAnchor.constraint(equalTo: self.addMoneyToProductTextField.heightAnchor),
            addMoneyToProductTextField.centerXAnchor.constraint(equalTo: stackView.centerXAnchor)
        ])
    }
    
    func setupButton() {
        createProductButton.addTarget(self, action: #selector(createProductButtonTap), for: .touchUpInside)
        createProductButton.setTitle("Создать продукт", for: .normal)
        createProductButton.setTitleColor(.systemBlue, for: .normal)
        createProductButton.setTitle("Создать продукт", for: .highlighted)
        createProductButton.setTitleColor(.lightGray, for: .highlighted)
        createProductButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            createProductButton.topAnchor.constraint(equalTo: addMoneyToProductTextField.bottomAnchor, constant: 10),
            createProductButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createProductButton.widthAnchor.constraint(equalTo: self.createProductButton.widthAnchor)
            
        ])
    }
}
