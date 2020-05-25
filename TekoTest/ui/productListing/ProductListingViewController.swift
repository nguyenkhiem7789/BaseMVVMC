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

protocol ProductListingDelegate {
    func openProductDetailScreen(sku: String)
}

class ProductListingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var searchTextField: DesignableTextField!

    var viewModel: ProductListingViewModel? = nil

    var arrayProduct = [Product]()

    let disposeBag = DisposeBag()

    var currentPage = 1

    var PAGE_SIZE = 10

    var query: String = ""

    var delegate: ProductListingDelegate?

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewWillAppear(_ animated: Bool) {
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to: #selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = "0xE63B0F".colorWithHexString()
        }
    }

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
        getDataCache()
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

    ///display data from Realm 
    private func getDataCache() {
        if let arrayProduct = RealmManager.shared.getObjects(type: Product.self) {
            print("XarrayProduct count = \(arrayProduct.count)")
            self.arrayProduct = arrayProduct
            self.tableView.reloadData()
        }
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
                print("XarrayProduct count = \(self.arrayProduct.count)")
                RealmManager.shared.deleteArrayObject(objs: self.arrayProduct)
                self.arrayProduct.removeAll()
            }
            DispatchQueue.main.async {
                RealmManager.shared.saveArrayObject(objs: arrayProduct)
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.delegate?.openProductDetailScreen(sku: arrayProduct[indexPath.item].sku)
    }

}
