//
//  ProductCompare.swift
//  TekoTest
//
//  Created by Nguyen on 5/24/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import SwiftyJSON

struct ProductCompareResponse {

    var arrayCompare: [ProductCompare]?

    init(json: JSON) {
        if let arrayCompareJson = json["data"].array {
           arrayCompare = [ProductCompare]()
           for dataJson in arrayCompareJson {
               let compare = ProductCompare(json: dataJson)
               arrayCompare?.append(compare)
           }
        }
    }
}


struct ProductCompare {

    var name: String?

    var price: Double?

    init(json: JSON) {
        name = json["name"].string
        price = json["price"].double
    }

}
