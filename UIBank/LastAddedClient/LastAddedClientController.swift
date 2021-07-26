//
//  LastAddedClientController.swift
//  UIBank
//
//  Created by Ivan Amakhin on 20.07.2021.
//

import UIKit

class LastAddedClientController: UIViewController {
    
    var bank: Bank!
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateData()
    }
    
    func updateData() {
        
        guard let lastClient = bank.users().last else { return }
        let formater = Formater()
        
        fullNameLabel.text = formater.format(fullname: lastClient)
        phoneNumberLabel.text = formater.format(phone: lastClient.phone)
        emailLabel.text = lastClient.email
        adressLabel.text = formater.format(adress: lastClient.address)
    }
}
