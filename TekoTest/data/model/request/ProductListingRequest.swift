//
//  ProductListingRequest.swift
//  TekoTest
//
//  Created by Nguyen on 5/22/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import SwiftyJSON

struct ProductListingRequest {

    var channel: String?

    var visitorId: String?

    var query: String?

    var terminal: String?

    var page: Int?

    var limit: Int?

    func getParams() -> String {
        var part = [String]()
        if let channel = channel {
            part.append("channel=\(channel)")
        }
        if let visitorId = visitorId {
            part.append("visitorId=\(visitorId)")
        }
        if let query = query {
            part.append("q=\(query)")
        }
        if let terminal = terminal {
            part.append("terminal=\(terminal)")
        }
        if let page = page {
            part.append("_page=\(page)")
        }
        if let limit = limit {
            part.append("_limit=\(limit)")
        }
        let finalQuery = part.joined(separator: "&")
        return finalQuery
    }
}
