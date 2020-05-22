//
//  SplashCoordinator.swift
//  DrugStoreClient
//
//  Created by Nguyen on 10/28/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

final class SplashCoordinator: Coordinator {

    fileprivate var isLoggedIn = false

    var splashViewController: SplashViewController?

    init() {
        start()
    }

    func start() {
        splashViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SplashViewController") as? SplashViewController
        splashViewController?.delegate = self
    }

    func getSplashViewController() -> SplashViewController? {
        return splashViewController
    }

    func showProductListingViewController() {
        let coordinator = ProductListingCoordinator(navigationController: splashViewController?.navigationController)
        coordinator.start()
    }

    deinit {
        print("deallocing \(self)")
    }

}

extension SplashCoordinator: SplashViewControllerDelegate {
    func showProductListingScreen() {
        showProductListingViewController()
    }
}
