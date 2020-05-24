//
//  ProductDetailViewController.swift
//  TekoTest
//
//  Created by Nguyen on 5/23/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxGesture
import ImageSlideshow

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var priceLabel: UILabel!

    @IBOutlet weak var imageSlideView: ImageSlideshow!

    @IBOutlet weak var nameDetailLabel: UILabel!

    @IBOutlet weak var codeLabel: UILabel!

    @IBOutlet weak var statusLabel: DesignableUILabel!

    @IBOutlet weak var finalPriceLabel: UILabel!

    @IBOutlet weak var totalPriceLabel: UILabel!

    @IBOutlet weak var promotionView: PromotionView!

    @IBOutlet weak var moreView: UIView!

    @IBOutlet weak var heightInfoConstraint: NSLayoutConstraint!

    @IBOutlet weak var blurView: UIView!

    @IBOutlet weak var displayInfoLabel: UILabel!

    @IBOutlet weak var displayInfoImageView: UIImageView!

    @IBOutlet weak var imageSlideEmpryView: UIImageView!

    @IBOutlet weak var genericProductsView: UICollectionView!

    var sku: String?

    var viewModel: ProductDetailViewModel?

    let disposeBag = DisposeBag()

    var heightContentInfo: CGFloat?

    var isExpanding = false

    var heightInfoViewStart = CGFloat(200)

    var arrayGenericProsucts = [ProductGeneric]()

    override func viewDidLoad() {
        initView()
        getDataCache()
        setupBinding()
        loadData()
    }

    private func initView() {
        moreView.rx
        .tapGesture()
        .when(.recognized)
        .subscribe(onNext: { _ in
            DispatchQueue.main.async {
                if !self.isExpanding {
                    if let heightContentInfo = self.heightContentInfo {
                        self.isExpanding = true
                        self.heightInfoConstraint.constant = heightContentInfo
                        self.blurView.isHidden = true
                        self.displayInfoLabel.text = "less_info".localized
                        self.displayInfoImageView.image = UIImage(named: "chevronUp")
                        self.view.layoutIfNeeded()
                    }
                } else {
                    self.isExpanding = false
                    self.heightInfoConstraint.constant = self.heightInfoViewStart
                    self.blurView.isHidden = false
                    self.displayInfoLabel.text = "more_info".localized
                    self.displayInfoImageView.image = UIImage(named: "chevronDown")
                    self.view.layoutIfNeeded()
                }
            }
        })
        .disposed(by: disposeBag)

        genericProductsView.delegate = self
        genericProductsView.dataSource = self
        let nib = UINib(nibName: "ProductGenericViewCell", bundle: nil)
        genericProductsView.register(nib, forCellWithReuseIdentifier: "ProductGenericViewCell")
    }

    ///display data from Realm
    private func getDataCache() {
        guard sku != nil else { return }
        if let product = RealmManager.shared.getObjects(type: Product.self)?.filter({$0.sku == self.sku}) {
            self.self.fillData(product: product[0])
        }
    }

    private func loadData() {
        guard let sku = self.sku else {
            return
        }
        var request = ProductDetailRequest()
        request.channel = "pv_online"
        request.terminal = "CP01"
        viewModel?.getProductDetail(productSku: sku, request: request)
    }

    private func setupBinding() {
        viewModel?.loading.bind(to: self.rx.isAnimating).disposed(by: disposeBag)

        viewModel?
        .errorMsg
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: {
              (error) in
              MessageView.shared.showOnView(message: error, theme: .error)
        }).disposed(by: disposeBag)

        viewModel?
        .product
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: {
            [weak self](product) in
            guard let self = self else { return }
            self.fillData(product: product)
        }).disposed(by: disposeBag)
    }

    private func fillData(product: Product) {
        ///image slide
        let arrayImage = Array(product.arrayImage)
        self.loadImageSlide(arrayImage: arrayImage)

        ///product property
        nameLabel.text = product.name
        nameDetailLabel.text = product.name
        if let sellPrice = product.price?.sellPrice {
            priceLabel.text = sellPrice.formatNumberCurrency()
        }
        codeLabel.text = product.sku
        statusLabel.textInsets = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)

        if let sellPrice = product.price?.sellPrice {
            finalPriceLabel.text = sellPrice.formatNumberCurrency()
        }
        if let supplierSalePrice = product.price?.supplierSalePrice {
            totalPriceLabel.attributedText = supplierSalePrice.formatNumberCurrency()?.strikeThrough()
        }
        if let sellPrice = product.price?.sellPrice, let supplierSalePrice = product.price?.supplierSalePrice, sellPrice < supplierSalePrice {
            let promotion = 100 - Double(round(100 * (sellPrice / supplierSalePrice) )/100) * 100
            promotionView.text = "-\(Int(promotion))%"
            promotionView.isHidden = false
            totalPriceLabel.isHidden = false
        } else {
            promotionView.isHidden = true
            totalPriceLabel.isHidden = true
        }

        ///generic products
        if let arrayGenericProsucts = viewModel?.getProductGeneric() {
            self.arrayGenericProsucts = arrayGenericProsucts
            genericProductsView.reloadData()
        }
    }

    ///load image slide
    func loadImageSlide(arrayImage: [ProductImage]) {
        var arraySource = [KingfisherSource]()
        if arrayImage.count > 0 {
            imageSlideEmpryView.isHidden = true
            for i in 0 ..< arrayImage.count {
                if let sourceImage = KingfisherSource(urlString: arrayImage[i].url) {
                    arraySource.append(sourceImage)
                }
            }
            let pageIndicator = UIPageControl()
            pageIndicator.currentPageIndicatorTintColor = "0xE63B0F".colorWithHexString()
            pageIndicator.pageIndicatorTintColor = UIColor.lightGray
            self.imageSlideView.pageIndicator = pageIndicator
            self.imageSlideView.contentScaleMode = .scaleAspectFill
            self.imageSlideView.setImageInputs(arraySource)
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTapImageSlide))
            self.imageSlideView.addGestureRecognizer(recognizer)
        } else {
            imageSlideEmpryView.isHidden = false
        }
    }

    @objc func didTapImageSlide() {
    }

    @IBAction func clickBackButon(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ProductInfo") {
            let vc = segue.destination as! ProductInfoViewController
            vc.getHeightContentListener = {
                [unowned self] height in
                print("height = \(height)")
                self.heightContentInfo = height
                if self.isExpanding {
                    DispatchQueue.main.async {
                        self.heightInfoConstraint.constant = height
                        self.view.layoutIfNeeded()
                    }
                }
            }
        }
    }

}

extension ProductDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayGenericProsucts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductGenericViewCell", for: indexPath) as! ProductGenericViewCell        
        cell.fillData(generic: arrayGenericProsucts[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 300)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }

}
