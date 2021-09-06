//
//  TextOption.swift
//  UIBank
//
//  Created by Ivan Amakhin on 02.09.2021.
//

import UIKit

extension UITextField {
    
    func textOptions(placeholder: String){
        
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:5, height:5)) // создание внутри текстфилда вьюхи чтобы были границы
        self.leftViewMode = UITextField.ViewMode.always
        self.rightViewMode = UITextField.ViewMode.always
        self.leftView = spacerView
        self.rightView = spacerView
        
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
