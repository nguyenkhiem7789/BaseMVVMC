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

    @IBOutlet weak var promotionPriceView: UIView!

    @IBOutlet weak var heightPromotionPriceConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fillData(product: Product) {
        if let arrayImage = product.arrayImage, arrayImage.count > 0, let url = URL(string: arrayImage[0].url) {
            productImageView.kf.setImage(with: url)
        } else {
            productImageView.image = UIImage(named: "empty")
        }
        nameLabel.text = product.name
        if let sellPrice = product.price?.sellPrice {
            finalPriceLabel.text = sellPrice.formatNumberCurrency()
        }
        if let supplierSalePrice = product.price?.supplierSalePrice {
            totalPriceLabel.attributedText = supplierSalePrice.formatNumberCurrency()?.strikeThrough()
        }
        if let sellPrice = product.price?.sellPrice, let supplierSalePrice = product.price?.supplierSalePrice, sellPrice < supplierSalePrice {
            let promotion = 100 - Double(round(100 * (sellPrice / supplierSalePrice) )/100) * 100
            promotionView.text = "-\(Int(promotion))%"
            promotionPriceView.isHidden = false
        } else {
            promotionPriceView.isHidden = true
        }
    }
    
}
