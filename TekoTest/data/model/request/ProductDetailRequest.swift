//
//  ProductDetailRequest.swift
//  TekoTest
//
//  Created by Nguyen on 5/23/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

struct ProductDetailRequest {

    var channel: String?

    var terminal: String?

    func getParams() -> String {
        var part = [String]()
        if let channel = channel {
            part.append("channel=\(channel)")
        }
        if let terminal = terminal {
            part.append("terminal=\(terminal)")
        }
        let finalQuery = part.joined(separator: "&")
        return finalQuery
    }

}
