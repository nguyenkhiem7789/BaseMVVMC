//
//  ProductListingViewModel.swift
//  TekoTest
//
//  Created by Nguyen on 5/21/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON

class ProductListingViewModel: BaseViewModel {

    private let disposeBag = DisposeBag()

    public let errorMsg: PublishSubject<String> = PublishSubject()
    public let arrayProduct: PublishSubject<[Product]> = PublishSubject()

    public func getListProduct(request: ProductListingRequest) {
        self.loading.onNext(true)
        provider.requestAPIJSON(api: .search(params: request.getParams())) {
        (success, message, data) -> (Void) in
        self.loading.onNext(false)
        if success, let data = data {
            let json = JSON(data)
            print("Xrequest getListProduct => \(json)")
            let response = ProductListingResponse(json: json)
            if let code = response.code, code == "SUCCESS" {
                if let arrayProduct = response.result?.arrayProduct {
                    self.arrayProduct.onNext(arrayProduct)
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

}

