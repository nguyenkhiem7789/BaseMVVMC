//
//  AppCoordinator.swift
//  DrugStoreClient
//
//  Created by Nguyen on 10/27/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

protocol Coordinator {
    func start()
}

final class AppCoordinator {

    fileprivate let navigationController: UINavigationController

    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.isNavigationBarHidden = true
    }

    deinit {
        print("deallocing \(self)")
    }

    func start() {
        showSplashScreen()
    }

    fileprivate func showSplashScreen() {
        let splashCoordinator = SplashCoordinator()
        splashCoordinator.start()
    }

    
}

