//
//  ProductListingViewController.swift
//  TekoTest
//
//  Created by Nguyen on 5/21/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxGesture

class ProductListingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var viewModel: ProductListingViewModel? = nil

    var arrayProduct = [Product]()

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 110
        self.tableView.register(UINib(nibName: "ProductListingViewCell", bundle: nil), forCellReuseIdentifier: "ProductListingViewCell")
        setupBinding()
        loadData(query: "")
    }

    private func loadData(query: String) {
        var request = ProductListingRequest()
        request.channel = "pv_online"
        request.visitorId = ""
        request.query = query
        request.terminal = "CP01"
        request.page = 1
        request.limit = 10
        viewModel?.getListProduct(request: request)
    }

    func checkDisplayEmptyView() {
        if arrayProduct.count == 0 {
            EmptyView.shared.show(view: self.tableView)
            EmptyView.shared.loadDataListener = {
                [unowned self] in

            }
        } else {
            EmptyView.shared.hide()
        }
    }

    private func setupBinding() {
        viewModel?
        .errorMsg
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: {
              [weak self](error) in
              MessageView.shared.showOnView(message: error, theme: .error)
              self?.checkDisplayEmptyView()
        }).disposed(by: disposeBag)

        viewModel?
        .arrayProduct
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: {
            [unowned self](arrayProduct) in
            self.arrayProduct = arrayProduct
            self.tableView.reloadData()
        }).disposed(by: disposeBag)

    }

}

extension ProductListingViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayProduct.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListingViewCell", for: indexPath) as! ProductListingViewCell
        cell.fillData(product: arrayProduct[indexPath.item])
        return cell
    }

}
