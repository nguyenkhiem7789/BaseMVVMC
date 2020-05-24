//
//  ProductDescription.swift
//  TekoTest
//
//  Created by Nguyen on 5/23/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import SwiftyJSON

struct ProductDescription {

    var description: String?

    init(json: JSON) {
        description = json["data"].string
    }

}
