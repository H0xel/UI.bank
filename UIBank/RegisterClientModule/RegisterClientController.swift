//
//  ViewController.swift
//  UIBank
//
//  Created by Ivan Amakhin on 12.07.2021.
//

import UIKit
import PhoneNumberKit

class RegisterClientController: UIViewController {
    
    
    var bank: Bank!
    let phoneNumberKit = PhoneNumberKit()
    
    
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
        
        nameTextField.delegate = self
        secondNameTextField.delegate = self
        lastNameTextField.delegate = self
        
        nameTextField.placeholder = "Имя"
        secondNameTextField.placeholder = "Отчество"
        lastNameTextField.placeholder = "Фамилия"
        emailTextField.placeholder = "Электронный адрес"
        
        
        numberPhoneTextField.placeholder = "Номер телефона"
        numberPhoneTextField.withFlag = true
        
        countryTextField.placeholder = "Страна"
        cityTextField.placeholder = "Город"
        streetTextField.placeholder = "Улица"
        houseTextField.placeholder = "Дом"
        flatTextField.placeholder = "Квартира"
        flatTextField.keyboardType = .numberPad
        
        floorTextField.placeholder = "Этаж"
        floorTextField.keyboardType = .numberPad
        
    }


    @IBAction func registerActionButton() {
        view.endEditing(true)
    
        let name = nameTextField.text ?? ""
        let secondName = secondNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        
        let numberPhone = numberPhoneTextField.text ?? ""

        let country = countryTextField.text ?? ""
        let city = cityTextField.text ?? ""
        let street = streetTextField.text ?? ""
        let house = houseTextField.text ?? ""
        let flat = flatTextField.text ?? ""
        let floor = floorTextField.text ?? ""

        
        let alert = UIAlertController(title: "", message: "Вы не заполнили поле.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: nil))
       
        if name.isEmpty ||
            secondName.isEmpty ||
            lastName.isEmpty ||
            email.isEmpty ||
            numberPhone.isEmpty ||
            country.isEmpty ||
            city.isEmpty ||
            street.isEmpty ||
            house.isEmpty ||
            flat.isEmpty ||
            floor.isEmpty {
                    nameTextField.layer.borderWidth = 1
                    nameTextField.layer.borderColor = UIColor.red.cgColor
            
                    lastNameTextField.layer.borderWidth = 1
                    lastNameTextField.layer.borderColor = UIColor.red.cgColor
                    self.present(alert, animated: true, completion: nil)
        } else {
            do {
                let phoneNumber = try phoneNumberKit.parse("\(numberPhone)")
                let phoneCountryCode = phoneNumber.countryCode
                let phoneNumberBody = phoneNumber.nationalNumber
                
                let client = bank.createClient(name: name,
                                  secondName: secondName,
                                  lastName: lastName,
                                  email: email,
                                  phone: Phone(countryCode: Int(phoneCountryCode),
                                               numberPhone: Int(phoneNumberBody)),
                                  address: Address(country: country,
                                                   city: city,
                                                   street: street,
                                                   house: house,
                                                   flat: Int(flat) ?? 0,
                                                   floor: Int(floor) ?? 0))
                print(client)
            }
                catch {
                print("Generic parser error")
            }
        }
    }
}


extension RegisterClientController: UITextFieldDelegate {
    
//  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//
//    enum regex: String {
//        case numbers = "[0-9]"
//        case letters = "[a-z A-Z а-я А-Я]"
//    }
//
//    func inputTypeLimit(_ textField: UITextField, regex: regex, min: Int, max: Int) -> Bool {
//        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
//        let regex = regex.rawValue + "{\(min),\(max)}"
//        let predicate = NSPredicate.init(format: "SELF MATCHES %@", regex as CVarArg)
//
//        if predicate.evaluate(with: text) || string == "" {
//            return true
//        } else {
//            return false
//        }
//    }
//
//    switch textField {
//
//    case nameTextField:
//        return inputTypeLimit(nameTextField, regex: .letters, min: 0, max: 15)
//    case secondNameTextField:
//        return inputTypeLimit(secondNameTextField, regex: .letters, min: 0, max: 15)
//    case lastNameTextField:
//        return inputTypeLimit(lastNameTextField, regex: .letters, min: 0, max: 15)
//    case numberPhoneTextField:
//        return inputTypeLimit(numberPhoneTextField, regex: .numbers, min: 0, max: 16)
//
//
//    default:
//        return false
//        }
//    }
}
