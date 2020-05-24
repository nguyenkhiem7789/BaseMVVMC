//
//  ProductListingResponse.swift
//  TekoTest
//
//  Created by Nguyen on 5/22/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift

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

class Product: Object {
    @objc var id = UUID().uuidString

    @objc dynamic var sku: String = ""

    @objc dynamic var name: String = ""

    @objc dynamic var price: ProductPrice?

    var arrayImage = List<ProductImage>()

    convenience init(json: JSON) {
        self.init()
        sku = json["sku"].string ?? ""
        name = json["name"].string ?? ""
        price = ProductPrice(json: json["price"])
        if let arrayImageJson = json["images"].array {
            for dataJson in arrayImageJson {
                let image = ProductImage(json: dataJson)
                arrayImage.append(image)
            }
        }
    }

}

class ProductImage: Object {

    @objc var id = UUID().uuidString

    @objc dynamic var url: String = ""

    @objc dynamic var priority: Int = 0

    convenience init(json: JSON) {
        self.init()
        url = json["url"].string ?? ""
        priority = json["priority"].int ?? 0
    }

}

class ProductPrice: Object {

    @objc var id = UUID().uuidString

    @objc dynamic var supplierSalePrice: Double = 0.0

    @objc dynamic var sellPrice: Double = 0.0

    convenience init(json: JSON) {
        self.init()
        supplierSalePrice = json["supplierSalePrice"].double ?? 0.0
        sellPrice = json["sellPrice"].double ?? 0.0
    }

}
