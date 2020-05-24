//
//  ProductSpecificationsViewController.swift
//  TekoTest
//
//  Created by Nguyen on 5/23/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ProductSpecificationsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let viewModel = ProductDetailViewModel()

    var arraySpecification = [ProductSpecification]()

    var height: CGFloat?

    var getHeightContentListener: ((_ height: CGFloat) -> (Void))?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "ProductSpecificationViewCell", bundle: nil), forCellReuseIdentifier: "ProductSpecificationViewCell")
        self.loadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        if let height = self.height {
            getHeightContentListener?(height)
        }
    }

    private func loadData() {
        if let arraySpecification = viewModel.getProductionSpecification() {
            self.arraySpecification = arraySpecification
            self.tableView.reloadData()        
            let height = CGFloat(self.arraySpecification.count * 44)
            self.height = height
            self.getHeightContentListener?(height)
        }
    }

}

extension ProductSpecificationsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraySpecification.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductSpecificationViewCell", for: indexPath) as! ProductSpecificationViewCell
        cell.fillData(specification: arraySpecification[indexPath.item], index: indexPath.item)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

}

extension ProductSpecificationsViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Thông số kỹ thuật".localized)
    }
}
