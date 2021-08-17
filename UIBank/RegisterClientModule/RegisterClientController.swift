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
    func displayPlaceholders(name: String,
                             secondName: String,
                             lastName: String,
                             email: String,
                             phone: String,
                             phoneWithFlag: Bool,
                             county: String,
                             city: String,
                             street: String,
                             house: String,
                             flat: String,
                             flatKeyboardType: UIKeyboardType,
                             floor: String,
                             floorKeyboardType: UIKeyboardType)
}

class RegisterClientController: UIViewController {
    
    var presenter: RegisterClientPresenter!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var secondNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var numberPhoneTextField: PhoneNumberTextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var houseTextField: UITextField!
    @IBOutlet weak var flatTextField: UITextField!
    @IBOutlet weak var floorTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewLoaded()
    }


    @IBAction func registerActionButton() {
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
    
    func displayPlaceholders(name: String,
                             secondName: String,
                             lastName: String,
                             email: String,
                             phone: String,
                             phoneWithFlag: Bool,
                             county: String,
                             city: String,
                             street: String,
                             house: String,
                             flat: String,
                             flatKeyboardType: UIKeyboardType,
                             floor: String,
                             floorKeyboardType: UIKeyboardType) {
        
        nameTextField.placeholder = name
        secondNameTextField.placeholder = secondName
        lastNameTextField.placeholder = lastName
        emailTextField.placeholder = email
        numberPhoneTextField.placeholder = phone
        numberPhoneTextField.withFlag = phoneWithFlag
        countryTextField.placeholder = county
        cityTextField.placeholder = city
        streetTextField.placeholder = street
        houseTextField.placeholder = house
        flatTextField.placeholder = flat
        flatTextField.keyboardType = flatKeyboardType
        floorTextField.placeholder = floor
        floorTextField.keyboardType = floorKeyboardType
    }
}

