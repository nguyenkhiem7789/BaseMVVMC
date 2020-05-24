//
//  ProductDescriptionViewController.swift
//  TekoTest
//
//  Created by Nguyen on 5/23/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ProductDescriptionViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!

    let viewModel = ProductDetailViewModel()

    var height: CGFloat?

    var getHeightContentListener: ((_ height: CGFloat) -> (Void))?

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        webView.scrollView.bounces = false
        webView.scrollView.isScrollEnabled = false
        if let description = viewModel.getProductionDescription() {
            let newContent = "<html><head><style>img{max-width:100%;height:auto !important;width:auto !important;};</style></head>"
                + "<body style='margin:16; padding:0;'><span style=\"font-family: SFUIText-Regular; font-size: 14\">\(description)</span></body></html>"
            self.webView.loadHTMLString(newContent, baseURL: nil)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        if let height = self.height {
            getHeightContentListener?(height)
        }
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        let height = webView.scrollView.contentSize.height + 20
        self.height = height
        getHeightContentListener?(height)
    }
}

extension ProductDescriptionViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Mô tả sản phẩm".localized)
    }
}
