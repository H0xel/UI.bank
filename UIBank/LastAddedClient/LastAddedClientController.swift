//
//  LastAddedClientController.swift
//  UIBank
//
//  Created by Ivan Amakhin on 20.07.2021.
//

import UIKit

class LastAddedClientController: UIViewController {
    
    var storageAssembly: StoragesAssembly!
    
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
        
        guard let lastClient = storageAssembly.userStorage.users().last else { return }
        
        fullNameLabel.text = lastClient.name + " " + lastClient.secondName + " " + lastClient.lastName
        
        phoneNumberLabel.text = String(lastClient.phone.countryCode) + String(lastClient.phone.numberPhone)
        
        emailLabel.text = lastClient.email
        
        adressLabel.text = lastClient.address.country + " " + lastClient.address.city + " " + lastClient.address.street + " " + String(lastClient.address.house) + " " + String(lastClient.address.flat) + " " + String(lastClient.address.floor)
    }
}
