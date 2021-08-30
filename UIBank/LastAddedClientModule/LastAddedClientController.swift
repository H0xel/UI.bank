//
//  LastAddedClientController.swift
//  UIBank
//
//  Created by Ivan Amakhin on 20.07.2021.
//

import UIKit

protocol LastAddedClientView: AnyObject {
    func display(fullname: String, email: String, phone: String, adress: String)
}


class LastAddedClientController: UIViewController {
    
    var presenter: LastAddedClientPresenter!
    
    let fullNameLabel = UILabel()
    let phoneNumberLabel = UILabel()
    let emailLabel = UILabel()
    let adressLabel = UILabel()
    let stackView = UIStackView()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter.viweWillAppeared()
    }
}

extension LastAddedClientController: LastAddedClientView {
    func display(fullname: String, email: String, phone: String, adress: String) {
        fullNameLabel.text = fullname
        phoneNumberLabel.text = phone
        emailLabel.text = email
        adressLabel.text = adress
        
        elementsAddedToView()
        elememntsSetupAdded()
    }
    
    func elementsAddedToView() {
        view.addSubview(stackView)
        stackView.addSubview(fullNameLabel)
        stackView.addSubview(phoneNumberLabel)
        stackView.addSubview(emailLabel)
        stackView.addSubview(adressLabel)
    }
    
    func elememntsSetupAdded() {
        setupStackView()
        setupFullNameLabel()
        setupPhoneNumberLabel()
        setupEmailLabel()
        setupAdressLabel()
    }
    
    func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            stackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20)
        ])
        
    }
    
    func setupFullNameLabel() {
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        fullNameLabel.font = UIFont.systemFont(ofSize: 14)
        
        NSLayoutConstraint.activate([
            fullNameLabel.topAnchor.constraint(equalTo: stackView.topAnchor),
            fullNameLabel.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            fullNameLabel.rightAnchor.constraint(equalTo: stackView.rightAnchor),
            fullNameLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
        
    }
    
    func setupPhoneNumberLabel() {
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberLabel.font = UIFont.systemFont(ofSize: 14)
        
        NSLayoutConstraint.activate([
            phoneNumberLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 20),
            phoneNumberLabel.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            phoneNumberLabel.rightAnchor.constraint(equalTo: stackView.rightAnchor),
            phoneNumberLabel.widthAnchor.constraint(lessThanOrEqualTo: stackView.widthAnchor)
        ])
    }
    
    func setupEmailLabel() {
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.font = UIFont.systemFont(ofSize: 14)
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 20),
            emailLabel.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            emailLabel.rightAnchor.constraint(equalTo: stackView.rightAnchor),
            emailLabel.widthAnchor.constraint(lessThanOrEqualTo: stackView.widthAnchor)
        ])
    }
    
    func setupAdressLabel() {
        adressLabel.translatesAutoresizingMaskIntoConstraints = false
        adressLabel.font = UIFont.systemFont(ofSize: 14)
        
        NSLayoutConstraint.activate([
            adressLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            adressLabel.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            adressLabel.rightAnchor.constraint(equalTo: stackView.rightAnchor),
            adressLabel.widthAnchor.constraint(lessThanOrEqualTo: stackView.widthAnchor)
        ])
    }
}
