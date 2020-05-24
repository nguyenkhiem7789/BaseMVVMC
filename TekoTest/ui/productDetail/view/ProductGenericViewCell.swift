//
//  ProductGenericViewCell.swift
//  TekoTest
//
//  Created by Nguyen on 5/24/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Kingfisher

class ProductGenericViewCell: UICollectionViewCell {

    @IBOutlet weak var genericImageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var finalPriceLabel: UILabel!

    @IBOutlet weak var totalPriceLabel: UILabel!

    @IBOutlet weak var promotionView: PromotionView!

    @IBOutlet weak var promotionPriceView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func fillData(generic: ProductGeneric) {
        if let image = generic.image, let url = URL(string: image) {
            genericImageView.kf.setImage(with: url)
        }
        nameLabel.text = generic.name
        if let finalPrice = generic.finalPrice {
            finalPriceLabel.text = finalPrice.formatNumberCurrency()
        }
        if let totalPrice = generic.totalPrice {
            totalPriceLabel.attributedText = totalPrice.formatNumberCurrency()?.strikeThrough()
        }
        if let sellPrice = generic.finalPrice, let supplierSalePrice = generic.totalPrice, sellPrice < supplierSalePrice {
            let promotion = 100 - Double(round(100 * (sellPrice / supplierSalePrice) )/100) * 100
            promotionView.text = "-\(Int(promotion))%"
            promotionPriceView.isHidden = false
        } else {
            promotionPriceView.isHidden = true
        }
    }

}
