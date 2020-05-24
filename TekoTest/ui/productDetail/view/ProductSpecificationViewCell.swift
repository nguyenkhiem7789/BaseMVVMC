//
//  ProductSpecificationViewCell.swift
//  TekoTest
//
//  Created by Nguyen on 5/23/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class ProductSpecificationViewCell: UITableViewCell {

    @IBOutlet weak var parrentView: UIView!

    @IBOutlet weak var keyLabel: UILabel!

    @IBOutlet weak var valueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fillData(specification: ProductSpecification, index: Int) {
        keyLabel.text = specification.key
        valueLabel.text = specification.value
        if index % 2 == 0 {
            parrentView.backgroundColor = "0xF0F3F5".colorWithHexString()
        } else {
            parrentView.backgroundColor = UIColor.white
        }
    }
    
}
