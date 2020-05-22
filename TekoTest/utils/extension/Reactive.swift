//
//  Reactive.swift
//  TekoTest
//
//  Created by Nguyen on 5/23/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {

    /// Bindable sink for `startAnimating()`, `stopAnimating()` methods.
    public var isAnimating: Binder<Bool> {
        return Binder(self.base, binding: { (vc, active) in
            if active {
                Loading.shared.show()
            } else {
                Loading.shared.dimiss()
            }
        })
    }

}
