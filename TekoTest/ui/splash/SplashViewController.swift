//
//  SplashViewController.swift
//  DrugStoreClient
//
//  Created by Nguyen on 10/28/19.
//  Copyright © 2019 Apple. All rights reserved.
//
import UIKit

protocol SplashViewControllerDelegate: class {
    func showProductListingScreen()
}

class SplashViewController: UIViewController {

    var delegate: SplashViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {            
            self.delegate?.showProductListingScreen()
        }
    }

}
