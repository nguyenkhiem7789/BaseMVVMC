//
//  RealmManager.swift
//  TekoTest
//
//  Created by Nguyen on 5/24/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import RealmSwift

class RealmManager {

    static let shared = RealmManager()

    let realm = try? Realm()

    ///delete table
    func deleteDatabase() {
        try! realm?.write({
            realm?.deleteAll()
        })
    }

    ///delete particular object
    func deleteObject(objs : Object) {
       try? realm?.write ({
            realm?.delete(objs)
       })
    }

    ///Save array of objects to database
    func saveObjects(objs: Object) {
        try? realm?.write ({
            /// If update = false, adds the object
            realm?.add(objs)
        })
    }

    /// editing the object
    func editObjects(objs: Object) {
        try? realm?.write ({
            /// If update = true, objects that are already in the Realm will be
            /// updated instead of added a new.
            realm?.add(objs, update: .all)
        })
    }

     ///Returs an array as Results<object>?
    func getObjects(type: Object.Type) -> Results<Object>? {
        return realm?.objects(type)
    }

}
