//
//  Results.swift
//  TekoTest
//
//  Created by Nguyen on 5/24/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import RealmSwift

extension Results {
    func toArray<T>(type: T.Type) -> [T] {
        return compactMap { $0 as? T }
    }
}
