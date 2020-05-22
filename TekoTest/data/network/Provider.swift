//
//  Provider.swift
//  IOSBaseMVVMC
//
//  Created by KhiemND on 10/3/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias RequestCompletion = ((_ success: Bool, _ error: String?, _ data: Any?) -> (Void))?

class Provider {

    var alamofireManager: Alamofire.Session?

    fileprivate var request: Request?

    fileprivate let networkTimeout: TimeInterval = 30.0

    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = networkTimeout
        configuration.timeoutIntervalForResource = networkTimeout
        alamofireManager = Alamofire.Session(configuration: configuration)
    }

    fileprivate func getDefaultHeaderTypeJSON() -> HTTPHeaders {
        var headers = HTTPHeaders()
        headers["Content-Type"] = "application/json; charset=UTF-8"
        if let accessToken = UserDefaultUtils.shared.getAccessToken() {
            headers["X-ApiToken"] = accessToken
        }
        headers["Accept"] = "application/vnd.api+json"
        return headers
    }

    func cancel() {
        request?.cancel()
    }
}

extension Provider {
    func requestAPIJSON(api: ClientApi, parameters: [String : Any]? = nil, headers: HTTPHeaders? = nil, encoding: ParameterEncoding? = nil, completion: RequestCompletion) {
        let url = api.baseURL + api.path
        let finalHeaders: HTTPHeaders = {
            if let headers = headers {
                return headers
            }
            return getDefaultHeaderTypeJSON()
        }()
        let finalEncoding: ParameterEncoding = {
            if let encoding = encoding {
                return encoding
            }
            return JSONEncoding.prettyPrinted
        }()

        alamofireManager?.request(url, method: api.method, parameters: parameters, encoding: finalEncoding, headers: finalHeaders).cURLDescription(calling: { (curl) in
            print(curl)
        }) .responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let data):
                completion?(true, nil, data)
                break
            case .failure( _):
                completion?(false, "kDefaultInternetError".localized, nil)
                break
            }
        })
    }

    func uploadFile(api: ClientApi, fileUpload: UIImage, headers: HTTPHeaders? = nil, encoding: ParameterEncoding? = nil, completion: RequestCompletion) {
           let url = api.baseURL + api.path
           let finalHeaders: HTTPHeaders = {
               if let headers = headers {
                   return headers
               }
               return getDefaultHeaderTypeJSON()
           }()
           alamofireManager?.upload(multipartFormData: { multipartFormData in
            if let imageData = fileUpload.jpegData(compressionQuality: 0.5) {
                multipartFormData.append(imageData, withName: "images1", fileName: "\(Date().timeIntervalSince1970).jpg", mimeType: "image/jpg")
               }
            }, to: url, method: api.method, headers: finalHeaders).response { encodingResult in
                switch encodingResult.result {
                   case .failure(let error):
                       completion?(false, error.localizedDescription, nil)
                   case .success(let value):
                       completion?(true, nil, value)
               }
           }
       }

       func uploadArrayFile(api: ClientApi, fileUploads: [UIImage], headers: HTTPHeaders? = nil, encoding: ParameterEncoding? = nil, completion: RequestCompletion) {
           let url = api.baseURL + api.path
           let finalHeaders: HTTPHeaders = {
               if let headers = headers {
                   return headers
               }
               return getDefaultHeaderTypeJSON()
           }()
           alamofireManager?.upload(multipartFormData: { multipartFormData in
               for i in 0 ..< fileUploads.count {
                if let imageData = fileUploads[i].jpegData(compressionQuality: 0.5) {
                    multipartFormData.append(imageData, withName: "images\(i + 1)", fileName: "\(Date().timeIntervalSince1970).jpg", mimeType: "image/jpg")
                   }
               }
            }, to: url, method: api.method, headers: finalHeaders).response { encodingResult in
                switch encodingResult.result {
                    case .failure(let error):
                        completion?(false, error.localizedDescription, nil)
                    case .success(let value):
                        completion?(true, nil, value)
                }
           }
    }
}



