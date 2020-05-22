//
//  AppUtils.swift
//  TekoTest
//
//  Created by Nguyen on 5/21/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

class AppUtils {

    static func readJSONFromFile(fileName: String) -> Any?
    {
        var json: Any?
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                json = try? JSONSerialization.jsonObject(with: data)
            } catch {
                // Handle error here
            }
        }
        return json
    }

    static func isLanguageEn() -> Bool {
        return Locale.current.languageCode == "en"
    }

}
