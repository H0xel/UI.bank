//
//  LastAddedClientController.swift
//  UIBank
//
//  Created by Ivan Amakhin on 20.07.2021.
//

import UIKit

class LastAddedClientController: UIViewController {
    
//    var bank: Bank!
    var presenter: lastAddedClientPresenterImpl!
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter.showLastClient()
    }
    
    func updateData() {
        
//        guard let lastClient = presenter.bank.users().last else { return }

        presenter.showLastClient()
//        fullNameLabel.text = formater.format(fullname: lastClient)
//        phoneNumberLabel.text = formater.format(phone: lastClient.phone)
//        emailLabel.text = lastClient.email
//        adressLabel.text = formater.format(adress: lastClient.address)
    }
}

extension LastAddedClientController: LastAddedClientViewProtocol {
    func setClient(fullname: String, email: String, phone: String, adress: String) {
        fullNameLabel.text = fullname
        emailLabel.text = email
        phoneNumberLabel.text = phone
        adressLabel.text = adress
    }
}
