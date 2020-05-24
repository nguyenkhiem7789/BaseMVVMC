//
//  ProductCompareViewController.swift
//  TekoTest
//
//  Created by Nguyen on 5/23/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ProductCompareViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let viewModel = ProductDetailViewModel()

    var arrayCompare = [ProductCompare]()

    var height: CGFloat?

    var getHeightContentListener: ((_ height: CGFloat) -> (Void))?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44
        self.tableView.register(UINib(nibName: "ProductCompareViewCell", bundle: nil), forCellReuseIdentifier: "ProductCompareViewCell")
        self.loadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        if let height = self.height {
            getHeightContentListener?(height)
        }
    }

    private func loadData() {
        if let arrayCompare = viewModel.getProductionCompare() {
            self.arrayCompare = arrayCompare
            self.tableView.reloadData()
            let height = CGFloat(self.arrayCompare.count * 44)
            self.height = height
            self.getHeightContentListener?(height)
        }
    }

}

extension ProductCompareViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCompare.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCompareViewCell", for: indexPath) as! ProductCompareViewCell
        cell.fillData(compare: arrayCompare[indexPath.item])
        return cell
    }
}

extension ProductCompareViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "So sánh giá".localized)
    }
}
