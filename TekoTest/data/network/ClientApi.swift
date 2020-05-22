//
//  ClientApi.swift
//  IOSBaseMVVMC
//
//  Created by Nguyen on 9/29/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import Alamofire

enum ClientApi {
    
    case search(params: String)
}

extension ClientApi: TargetType {

    /// The target's base `URL`.
    var baseURL: String {
        return BASE_URL
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .search(let params):
            return "search/?".appending(params)
        }
    }
    
    /// The HTTP method used in the request.
    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    /// The type of HTTP task to be performed.
    var task: Task {
        return .request
    }

}
