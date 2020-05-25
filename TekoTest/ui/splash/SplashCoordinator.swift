//
//  SplashCoordinator.swift
//  DrugStoreClient
//
//  Created by Nguyen on 10/28/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

final class SplashCoordinator: Coordinator {

    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showSplashViewController()
    }

    func showSplashViewController() {
        if let splashViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SplashViewController") as? SplashViewController {
            splashViewController.delegate = self
            navigationController.pushViewController(splashViewController, animated: true)
        }
    }

    func showProductListingViewController() {
        let coordinator = ProductListingCoordinator(navigationController: navigationController)
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
