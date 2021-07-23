//
//  ClientDetailVC.swift
//  UIBank
//
//  Created by Ivan Amakhin on 14.07.2021.
//

import UIKit

class ClientDetailVC: UIViewController {

    @IBOutlet weak var clientFullNameLabel: UILabel!
    @IBOutlet weak var clientMobileNumberLabel: UILabel!
    @IBOutlet weak var clientEmailLabel: UILabel!
    @IBOutlet weak var clientAdressLabel: UILabel!
    
    var fullnameTittle = ""
    var mobilePhoneNumberTittle = ""
    var emailTittle = ""
    var adressTittle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clientFullNameLabel.text = fullnameTittle
        clientFullNameLabel.numberOfLines = 0
        clientMobileNumberLabel.text = mobilePhoneNumberTittle
        clientEmailLabel.text = emailTittle
        clientAdressLabel.text = adressTittle
        clientAdressLabel.numberOfLines = 0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
