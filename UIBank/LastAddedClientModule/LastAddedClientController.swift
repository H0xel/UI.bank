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
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    
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
    }
}
