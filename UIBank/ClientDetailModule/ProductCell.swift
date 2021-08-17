//
//  ProductCell.swift
//  UIBank
//
//  Created by Ivan Amakhin on 09.08.2021.
//

import UIKit

class ProductCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
