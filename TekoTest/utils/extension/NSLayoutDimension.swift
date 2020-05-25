//
//  NSLayoutDimension.swift
//  TekoTest
//
//  Created by Nguyen on 5/25/20.
//  Copyright © 2020 Apple. All rights reserved.
//
import Foundation
import UIKit

extension NSLayoutDimension {

@discardableResult
func set(
        to constant: CGFloat,
        priority: UILayoutPriority = .required
        ) -> NSLayoutConstraint {

        let cons = constraint(equalToConstant: constant)
        cons.priority = priority
        cons.isActive = true
        return cons
    }
}
