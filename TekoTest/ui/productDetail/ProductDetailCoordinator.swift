//
//  ProductDetailCoordinator.swift
//  TekoTest
//
//  Created by Nguyen on 5/23/20.
//  Copyright © 2020 Apple. All rights reserved.
//
import Foundation
import UIKit

class ProductDetailCoordinator: Coordinator {

    func start() {
    }

    let navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func start(sku: String) {
        showProductDetailViewController(sku: sku)
    }

    func showProductDetailViewController(sku: String) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController {
            viewController.sku = sku
            let viewModel = ProductDetailViewModel()
            viewController.viewModel = viewModel
            self.navigationController!.pushViewController(viewController, animated: true)
        }
    }

    deinit {
        print("deallocing \(self)")
    }

}
