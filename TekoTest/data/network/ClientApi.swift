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
    
    case login
}

extension ClientApi: TargetType {

    /// The target's base `URL`.
    var baseURL: String {
        return BASE_URL
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .login:
            return "/api/auth/login_store"
        }
    }
    
    /// The HTTP method used in the request.
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        }
    }
    
    /// The type of HTTP task to be performed.
    var task: Task {
        return .request
    }
    
}
