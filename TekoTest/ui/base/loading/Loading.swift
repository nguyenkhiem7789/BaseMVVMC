//
//  Dove
//
//  Created by Nguyen on 6/24/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit

class Loading {

    var containerView = UIView()
    var progressView = UIView()
    var activityIndicator = UIActivityIndicatorView()

    static let shared: Loading = Loading()

    func show() {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        containerView.frame = window.frame
        containerView.center = window.center
        containerView.backgroundColor = "0xffffff".colorWithHexString(alpha: 0.3)

        progressView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        progressView.center = window.center
        progressView.backgroundColor = "0x444444".colorWithHexString(alpha: 0.7)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 10

        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = .whiteLarge
        activityIndicator.center = CGPoint(x: progressView.bounds.width / 2, y: progressView.bounds.height / 2)

        progressView.addSubview(activityIndicator)
        containerView.addSubview(progressView)
        window.addSubview(containerView)

        activityIndicator.startAnimating()
    }

    func dimiss() {
        activityIndicator.stopAnimating()
        containerView.removeFromSuperview()
    }
}

