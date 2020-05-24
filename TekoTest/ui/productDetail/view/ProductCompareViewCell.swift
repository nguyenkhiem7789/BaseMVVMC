//
//  ProductSpecificationViewCell.swift
//  TekoTest
//
//  Created by Nguyen on 5/23/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class ProductCompareViewCell: UITableViewCell {

    @IBOutlet weak var parrentView: UIView!

    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fillData(compare: ProductCompare) {
        nameLabel.text = compare.name
        if let price = compare.price?.formatNumberCurrency() {
            priceLabel.text = price
        }
    }
    
}
