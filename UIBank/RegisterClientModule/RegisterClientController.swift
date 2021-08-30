//
//  ViewController.swift
//  UIBank
//
//  Created by Ivan Amakhin on 12.07.2021.
//

import UIKit
import PhoneNumberKit

struct ViewState {
    let firstName: String?
    let secondName: String?
    let lastName: String?
    let email: String?
    let numberPhone: String?
    let country: String?
    let city: String?
    let street: String?
    let house: String?
    let flat: String?
    let floor: String?
}

protocol RegisterClientView: AnyObject{
    var viewState: ViewState? { get }
    func display()
}



class RegisterClientController: UIViewController {
    
    var presenter: RegisterClientPresenter!
    
    let nameTextField = UITextField()
    let secondNameTextField = UITextField()
    let lastNameTextField = UITextField()
    let emailTextField = UITextField()
    let numberPhoneTextField = PhoneNumberTextField()
    let countryTextField = UITextField()
    let cityTextField = UITextField()
    let streetTextField = UITextField()
    let houseTextField = UITextField()
    let flatTextField = UITextField()
    let floorTextField = UITextField()
    let registerButton = UIButton()
    let stackView = UIStackView()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewLoaded()
    }
    
    @objc func registerButtonTap() {
        view.endEditing(true)
        presenter.registerButtonTapped()
    }
}

extension RegisterClientController: RegisterClientView {
    var viewState: ViewState? {
        ViewState(firstName: nameTextField.text,
                  secondName: secondNameTextField.text,
                  lastName: lastNameTextField.text,
                  email: emailTextField.text,
                  numberPhone: numberPhoneTextField.text,
                  country: countryTextField.text,
                  city: cityTextField.text,
                  street: streetTextField.text,
                  house: houseTextField.text,
                  flat: flatTextField.text,
                  floor: floorTextField.text)
    }
    
    func display() {
        elementsAddedToView()
        elementsSetupAdded()
    }
    
    func elementsAddedToView() {
        view.addSubview(stackView)
        stackView.addSubview(nameTextField)
        stackView.addSubview(secondNameTextField)
        stackView.addSubview(lastNameTextField)
        stackView.addSubview(emailTextField)
        stackView.addSubview(numberPhoneTextField)
        stackView.addSubview(countryTextField)
        stackView.addSubview(cityTextField)
        stackView.addSubview(streetTextField)
        stackView.addSubview(houseTextField)
        stackView.addSubview(flatTextField)
        stackView.addSubview(floorTextField)
        stackView.addSubview(registerButton)
    }
    
    func setupStackView() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            stackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    func elementsSetupAdded() {
        setupStackView()
        setupNameTextField()
        setupSecondNameTextField()
        setupLastNameTextField()
        setupEmailNameTextField()
        setupNumberPhoneTextField()
        setupCountryTextField()
        setupCityTextField()
        setupStreetextField()
        setupHouseTextField()
        setupFlatTextField()
        setupFloorTextField()
        setupRegisterButton()
    }
    
    
    func setupNameTextField() {
        nameTextField.textOptions(placeholder: "Имя")
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: stackView.topAnchor),
            nameTextField.heightAnchor.constraint(lessThanOrEqualToConstant: 34),
            nameTextField.widthAnchor.constraint(equalTo: secondNameTextField.widthAnchor, multiplier: 1/3),
            nameTextField.leftAnchor.constraint(equalTo: stackView.leftAnchor)
        ])
    }
    
    func setupSecondNameTextField() {
        secondNameTextField.textOptions(placeholder: "Отчество")
        secondNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            secondNameTextField.topAnchor.constraint(equalTo: nameTextField.topAnchor),
            secondNameTextField.leftAnchor.constraint(equalTo: nameTextField.rightAnchor, constant: 20),
            secondNameTextField.widthAnchor.constraint(lessThanOrEqualTo: stackView.widthAnchor),
            secondNameTextField.rightAnchor.constraint(equalTo: stackView.rightAnchor),
            secondNameTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor)
        ])
    }
    
    func setupLastNameTextField() {
        lastNameTextField.textOptions(placeholder: "Фамилия")
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            lastNameTextField.widthAnchor.constraint(lessThanOrEqualTo: stackView.widthAnchor),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 34),
            lastNameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            lastNameTextField.leftAnchor.constraint(equalTo: nameTextField.leftAnchor),
            lastNameTextField.rightAnchor.constraint(equalTo: secondNameTextField.rightAnchor)
        ])
    }
    
    func setupEmailNameTextField() {
        emailTextField.textOptions(placeholder: "Email")
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailTextField.widthAnchor.constraint(lessThanOrEqualTo: stackView.widthAnchor),
            emailTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            emailTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 10),
            emailTextField.leftAnchor.constraint(equalTo: nameTextField.leftAnchor),
            emailTextField.rightAnchor.constraint(equalTo: secondNameTextField.rightAnchor)
        ])
    }
    
    func setupNumberPhoneTextField() {
        numberPhoneTextField.textOptions(placeholder: "Номер телефона")
        numberPhoneTextField.translatesAutoresizingMaskIntoConstraints = false
        numberPhoneTextField.withFlag = true
        
        NSLayoutConstraint.activate([
            numberPhoneTextField.widthAnchor.constraint(lessThanOrEqualTo: stackView.widthAnchor),
            numberPhoneTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            numberPhoneTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            numberPhoneTextField.leftAnchor.constraint(equalTo: nameTextField.leftAnchor),
            numberPhoneTextField.rightAnchor.constraint(equalTo: secondNameTextField.rightAnchor)
        ])
    }
    
    
    func setupCountryTextField() {
        countryTextField.textOptions(placeholder: "Cтрана")
        countryTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            countryTextField.widthAnchor.constraint(lessThanOrEqualTo: stackView.widthAnchor, multiplier: 1/2),
            countryTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            countryTextField.topAnchor.constraint(equalTo: numberPhoneTextField.bottomAnchor, constant: 10),
            countryTextField.leftAnchor.constraint(equalTo: stackView.leftAnchor)
        ])
    }
    
    func setupCityTextField() {
        cityTextField.textOptions(placeholder: "Город")
        cityTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cityTextField.widthAnchor.constraint(equalTo: countryTextField.widthAnchor),
            cityTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            cityTextField.topAnchor.constraint(equalTo: numberPhoneTextField.bottomAnchor, constant: 10),
            cityTextField.leftAnchor.constraint(equalTo: countryTextField.rightAnchor, constant: 20),
            cityTextField.rightAnchor.constraint(equalTo: stackView.rightAnchor)
        ])
    }
    func setupStreetextField() {
        streetTextField.textOptions(placeholder: "Улица")
        streetTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            streetTextField.widthAnchor.constraint(lessThanOrEqualTo: stackView.widthAnchor),
            streetTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            streetTextField.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 10),
            streetTextField.leftAnchor.constraint(equalTo: nameTextField.leftAnchor),
            streetTextField.rightAnchor.constraint(equalTo: secondNameTextField.rightAnchor)
        ])
    }
    
    func setupHouseTextField() {
        houseTextField.textOptions(placeholder: "Дом")
        houseTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            houseTextField.widthAnchor.constraint(lessThanOrEqualTo: stackView.widthAnchor, multiplier: 1/3),
            houseTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            houseTextField.topAnchor.constraint(equalTo: streetTextField.bottomAnchor, constant: 10),
            houseTextField.leftAnchor.constraint(equalTo: stackView.leftAnchor)
        ])
    }
    
    func setupFlatTextField() {
        flatTextField.textOptions(placeholder: "Квартира")
        flatTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            flatTextField.widthAnchor.constraint(equalTo: houseTextField.widthAnchor),
            flatTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            flatTextField.topAnchor.constraint(equalTo: streetTextField.bottomAnchor, constant: 10),
            flatTextField.leftAnchor.constraint(equalTo: houseTextField.rightAnchor, constant: 20)
        ])
    }
    
    func setupFloorTextField() {
        floorTextField.textOptions(placeholder: "Этаж")
        floorTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            floorTextField.widthAnchor.constraint(equalTo: houseTextField.widthAnchor),
            floorTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            floorTextField.topAnchor.constraint(equalTo: streetTextField.bottomAnchor, constant: 10),
            floorTextField.leftAnchor.constraint(equalTo: flatTextField.rightAnchor, constant: 20),
            floorTextField.rightAnchor.constraint(equalTo: stackView.rightAnchor)
        ])
    }
    
    func setupRegisterButton() {
        registerButton.addTarget(self, action: #selector(registerButtonTap), for: .touchUpInside)
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.setTitle("Зарегистрировать", for: .normal)
        registerButton.setTitleColor(.blue, for: .normal)
        registerButton.setTitle("Зарегистрировать", for: .highlighted)
        registerButton.setTitleColor(.lightGray, for: .highlighted)
        registerButton.titleLabel?.textAlignment = .center
        
        NSLayoutConstraint.activate([
            registerButton.widthAnchor.constraint(lessThanOrEqualTo: self.registerButton.widthAnchor),
            registerButton.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            registerButton.topAnchor.constraint(equalTo: floorTextField.bottomAnchor, constant: 10),
            registerButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
        ])
    }
}

extension UITextField {
    
    func textOptions(placeholder: String){
        
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:5, height:5)) // создание внутри текстфилда вьюхи чтобы были границы
        self.leftViewMode = UITextField.ViewMode.always
        self.leftView = spacerView
        
        self.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                                  attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont.systemFont(ofSize: 14.0)
        ])
        self.font = UIFont.systemFont(ofSize: 14.0)
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
}
