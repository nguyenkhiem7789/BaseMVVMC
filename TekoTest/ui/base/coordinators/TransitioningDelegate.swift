//
//  TransitioningDelegate.swift
//  DrugStoreClient
//
//  Created by Nguyen on 10/27/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

final class TransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return nil
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return NavigationAnimator()
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return NavigationAnimator()
    }

}
