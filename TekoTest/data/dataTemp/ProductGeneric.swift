//
//  ProductGeneric.swift
//  TekoTest
//
//  Created by Nguyen on 5/24/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import SwiftyJSON

struct ProductGenericResponse {

    var arrayGeneric: [ProductGeneric]?

    init(json: JSON) {
        if let arrayGenericJson = json["data"].array {
           arrayGeneric = [ProductGeneric]()
           for dataJson in arrayGenericJson {
               let generic = ProductGeneric(json: dataJson)
               arrayGeneric?.append(generic)
           }
        }
    }
}

struct ProductGeneric {

    var image: String?

    var name: String?

    var finalPrice: Double?

    var totalPrice: Double?

    init(json: JSON) {
        image = json["image"].string
        name = json["name"].string
        finalPrice = json["finalPrice"].double
        totalPrice = json["totalPrice"].double
    }

}
