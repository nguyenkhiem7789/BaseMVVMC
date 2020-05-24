//
//  ProductListingResponse.swift
//  TekoTest
//
//  Created by Nguyen on 5/22/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import SwiftyJSON

struct ProductListingResponse {

    var code: String?

    var errorMsg: String?

    var result: ProuductResult?

    init(json: JSON) {
        code = json["code"].string
        errorMsg = json["error_msg"].string
        result = ProuductResult(json: json["result"])
    }

}

struct ProuductResult {

    var arrayProduct: [Product]?

    init(json: JSON) {
        if let arrayProductJson = json["products"].array {
           arrayProduct = [Product]()
           for dataJson in arrayProductJson {
               let product = Product(json: dataJson)
               arrayProduct?.append(product)
           }
        }
    }

}

struct Product {

    var sku: String?

    var name: String?

    var price: ProductPrice?

    var arrayImage: [ProductImage]?

    init(json: JSON) {

        sku = json["sku"].string

        name = json["name"].string

        price = ProductPrice(json: json["price"])

        if let arrayImageJson = json["images"].array {
           arrayImage = [ProductImage]()
           for dataJson in arrayImageJson {
               let image = ProductImage(json: dataJson)
               arrayImage?.append(image)
           }
        }
    }

}

struct ProductImage {

    var url: String?

    var priority: Int?

    init(json: JSON) {
        url = json["url"].string
        priority = json["priority"].int
    }

}

struct ProductPrice {

    var supplierSalePrice: Double?

    var sellPrice: Double?

    init(json: JSON) {
        supplierSalePrice = json["supplierSalePrice"].double
        sellPrice = json["sellPrice"].double
    }

}
