//
//  ProductDetailViewModel.swift
//  TekoTest
//
//  Created by Nguyen on 5/23/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON

class ProductDetailViewModel: BaseViewModel {

    private let disposeBag = DisposeBag()

    public let errorMsg: PublishSubject<String> = PublishSubject()
    public let product: PublishSubject<Product> = PublishSubject()

    public func getProductDetail(productSku: String, request: ProductDetailRequest) {
        self.loading.onNext(true)
        provider.requestAPIJSON(api: .getDetailProduct(productSku: productSku, params: request.getParams())) {
        (success, message, data) -> (Void) in
        self.loading.onNext(false)
        if success, let data = data {
            let json = JSON(data)
            print("Xrequest getProductDetail => \(json)")
            let response = ProductDetailResponse(json: json)
            if let code = response.code, code == "SUCCESS" {
                if let product = response.result?.product {
                    self.product.onNext(product)
                } else if let errorMsg = response.errorMsg {
                   self.errorMsg.onNext(errorMsg)
                }
            }
        } else {
                if let message = message {
                    self.errorMsg.onNext(message)
                }
            }
       }
    }

    ///get temp product description from json file
    public func getProductionDescription() -> String? {
        if let data = AppUtils.readJSONFromFile(fileName: "product_description") {
            let json = JSON(data)
            let response = ProductDescription(json: json)
            return response.description
        }
        return nil
    }

    ///get temp product specification from json file
    public func getProductionSpecification() -> [ProductSpecification]? {
        if let data = AppUtils.readJSONFromFile(fileName: "product_specification") {
            let json = JSON(data)
            let response = ProductSpecificationResponse(json: json)
            return response.arraySpecification
        }
        return nil
    }

    ///get temp product compare from json file
    public func getProductionCompare() -> [ProductCompare]? {
        if let data = AppUtils.readJSONFromFile(fileName: "product_compare") {
            let json = JSON(data)
            let response = ProductCompareResponse(json: json)
            return response.arrayCompare
        }
        return nil
    }

    ///get temp product generic from json file
    public func getProductGeneric() -> [ProductGeneric]? {
        if let data = AppUtils.readJSONFromFile(fileName: "product_generic") {
            let json = JSON(data)
            let response = ProductGenericResponse(json: json)
            return response.arrayGeneric
        }
        return nil
    }

}
