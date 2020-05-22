//
//  ProductListingViewCell.swift
//  TekoTest
//
//  Created by Nguyen on 5/22/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Kingfisher

class ProductListingViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var finalPriceLabel: UILabel!

    @IBOutlet weak var totalPriceLabel: UILabel!

    @IBOutlet weak var promotionView: PromotionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fillData(product: Product) {
        if let arrayImage = product.arrayImage, arrayImage.count > 0, let image = arrayImage[0].url, let url = URL(string: image) {
            productImageView.kf.setImage(with: url)
        }
        nameLabel.text = product.name
        if let sellPrice = product.price?.sellPrice {
            finalPriceLabel.text = sellPrice.formatNumberCurrency()
        }
        if let supplierSalePrice = product.price?.supplierSalePrice {
            totalPriceLabel.attributedText = supplierSalePrice.formatNumberCurrency()?.strikeThrough()
        }
    }
    
}
