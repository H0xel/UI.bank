//
//  MainPresenter.swift
//  UIBank
//
//  Created by Ivan Amakhin on 27.07.2021.
//

import Foundation
import EasyDi
import PhoneNumberKit



protocol RegisterClientPresenter{
    func registerButtonTapped()
    func viewLoaded()
}

class RegisterClientPresenterImpl: RegisterClientPresenter {

    weak var view: RegisterClientView?
    var bank: Bank!
    let phoneNumberKit = PhoneNumberKit()
    
    func registerButtonTapped() {
        
        guard let firstName = view?.viewState?.firstName,
              let secondName = view?.viewState?.secondName,
              let lastName = view?.viewState?.lastName,
              let email = view?.viewState?.email,
              let phone = view?.viewState?.numberPhone,
              let country = view?.viewState?.country,
              let city = view?.viewState?.city,
              let street = view?.viewState?.street,
              let house = view?.viewState?.house,
              let flat = view?.viewState?.flat,
              let floor = view?.viewState?.floor
        else { return }
        
        do {
            let phoneNumber = try phoneNumberKit.parse("\(phone)")
            let phoneCountryCode = phoneNumber.countryCode
            let phoneNumberBody = phoneNumber.nationalNumber
            
            let client = bank.createClient(name: firstName,
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
    
    func viewLoaded() {
        view?.display()
    }
}
