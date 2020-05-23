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

    @IBOutlet weak var searchTextField: DesignableTextField!

    var viewModel: ProductListingViewModel? = nil

    var arrayProduct = [Product]()

    let disposeBag = DisposeBag()

    var currentPage = 1

    var PAGE_SIZE = 10

    var query: String = ""

    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 110
        self.tableView.register(UINib(nibName: "ProductListingViewCell", bundle: nil), forCellReuseIdentifier: "ProductListingViewCell")
        tableView.addPullToRefreshHandler {
            self.currentPage = 1
            self.loadData(query: self.query)
        }
        tableView.addInfiniteScrollingWithHandler {
            self.loadData(query: self.query)
        }

        setupBinding()
        Loading.shared.show()
        loadData(query: self.query)
        search()
    }

    private func loadData(query: String) {
        var request = ProductListingRequest()
        request.channel = "pv_online"
        request.visitorId = ""
        request.query = query
        request.terminal = "CP01"
        request.page = currentPage
        request.limit = PAGE_SIZE
        viewModel?.getListProduct(request: request)
    }

    private func setupBinding() {
        viewModel?.loading.observeOn(MainScheduler.instance)
        .subscribe(onNext: {
            [weak self](loading) in
            if loading {
                Loading.shared.show()
            } else {
                Loading.shared.dimiss()
                self?.tableView.infiniteScrollingView?.stopAnimating()
                self?.tableView.pullToRefreshView?.stopAnimating()
            }
        }).disposed(by: disposeBag)

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
            [weak self](arrayProduct) in
            guard let self = self else { return }
            if self.currentPage == 1 {
                self.arrayProduct.removeAll()
            }
            self.currentPage += 1
            self.arrayProduct.append(contentsOf: arrayProduct)
            self.tableView.reloadData()
            self.checkDisplayEmptyView()
        }).disposed(by: disposeBag)

    }

    ///listener search
    private func search() {
        searchTextField
            .rx
            .text
            .map {$0!}
            .distinctUntilChanged()
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                [weak self] query in
                guard let self = self else { return }
                self.query = query
                if query.count > 0 {
                    self.searchTextField.displayRightImageView(isDisplay: true)
                } else {
                    self.searchTextField.displayRightImageView(isDisplay: false)
                }
                Loading.shared.show()
                self.currentPage = 1
                self.loadData(query: query)
            })
            .disposed(by: disposeBag)

        searchTextField.clickRightImageViewListener = {
            [unowned self] in
            self.query = ""
            self.searchTextField.text = nil
            self.searchTextField.displayRightImageView(isDisplay: false)
            Loading.shared.show()
            self.currentPage = 1
            self.loadData(query: self.query)
        }
    }

    private func checkDisplayEmptyView() {
        if arrayProduct.count == 0 {
            EmptyView.shared.show(view: self.tableView)
            EmptyView.shared.loadDataListener = {
                [unowned self] in
                Loading.shared.show()
                self.currentPage = 1
                self.loadData(query: self.query)
            }
        } else {
            EmptyView.shared.hide()
        }
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
