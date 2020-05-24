//
//  ProductInfoViewController.swift
//  TekoTest
//
//  Created by Nguyen on 5/23/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ProductInfoViewController: ButtonBarPagerTabStripViewController {

    var getHeightContentListener: ((_ height: CGFloat) -> (Void))?

    override func viewDidLoad() {
        self.loadDesign()
        super.viewDidLoad()
    }

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let productDescription = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDescriptionViewController") as! ProductDescriptionViewController
        productDescription.getHeightContentListener = {
            [unowned self] height in
            self.getHeightContentListener?(height)
        }

        let productSpecifications = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductSpecificationsViewController") as! ProductSpecificationsViewController
        productSpecifications.getHeightContentListener = {
            [unowned self] height in
            self.getHeightContentListener?(height)
        }

        let productCompare = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductCompareViewController") as! ProductCompareViewController
        productCompare.getHeightContentListener = {
            [unowned self] height in
            self.getHeightContentListener?(height)
        }

        return [productDescription, productSpecifications, productCompare]
    }

    func loadDesign() {
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = "0xE63B0F".colorWithHexString()
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarHeight = 40
        settings.style.buttonBarItemTitleColor = "0x2B2D2E".colorWithHexString()
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0

        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = "0x9A9FA2".colorWithHexString()
            newCell?.label.textColor = "0x2B2D2E".colorWithHexString()
        }
    }

}
