//
//  ProductDetailResponse.swift
//  TekoTest
//
//  Created by Nguyen on 5/23/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProductDetailResponse: NSObject {

    var code: String?

    var errorMsg: String?

    var result: ProuductDetailResult?

    init(json: JSON) {
        code = json["code"].string
        errorMsg = json["error_msg"].string
        result = ProuductDetailResult(json: json["result"])
    }

}

struct ProuductDetailResult {

    var product: Product?

    init(json: JSON) {
        product = Product(json: json["product"])
    }

}
