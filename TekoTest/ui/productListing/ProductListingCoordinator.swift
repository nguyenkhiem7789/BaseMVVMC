//
//  ProductListingCoordinator.swift
//  TekoTest
//
//  Created by Nguyen on 5/21/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit

class ProductListingCoordinator: Coordinator {

    let navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func start() {
        showProductListingViewController()
    }

    func showProductListingViewController() {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductListingViewController") as? ProductListingViewController {            
            viewController.delegate = self
            let viewModel = ProductListingViewModel()
            viewController.viewModel = viewModel
            self.navigationController!.pushViewController(viewController, animated: true)
        }
    }

    func openProductDetailViewController(sku: String) {
        let coordinator = ProductDetailCoordinator(navigationController: self.navigationController)
        coordinator.start(sku: sku)
    }

    deinit {
        print("deallocing \(self)")
    }
}

extension ProductListingCoordinator: ProductListingDelegate {

    func openProductDetailScreen(sku: String) {
        self.openProductDetailViewController(sku: sku)
    }

}
