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

    // MARK: - Save a object
    ///delete particular object
    func deleteObject(objs : Object) {
       try? realm?.write ({
            realm?.delete(objs)
       })
    }

    ///Save  object to database
    func saveObject(objs: Object) {
        try? realm?.write ({
            /// If update = false, adds the object
            realm?.add(objs)
        })
    }

    /// editing the object
    func editObject(objs: Object) {
        try? realm?.write ({
            /// If update = true, objects that are already in the Realm will be
            /// updated instead of added a new.
            realm?.add(objs, update: .all)
        })
    }

    // MARK: - Save array objects
    ///Save a list object
    func saveArrayObject(objs: [Object]) {
        try? realm?.write ({
            /// If update = false, adds the object
            realm?.add(objs)
        })
    }

    ///Remove a array object
    func deleteArrayObject(objs: [Object]) {
        try? realm?.write ({
            print("XXXX => delete array")
             realm?.delete(objs)
        })
    }

    // MARK: - get array object
    func getObjects<T: Object>(type: T.Type) -> [T]? {
        if let results = realm?.objects(type) {
            return Array(results)
        }
        return nil
    }

    func getObjectsResults(type: Object.Type) -> Results<Object>? {
        return realm?.objects(type)
    }

}
