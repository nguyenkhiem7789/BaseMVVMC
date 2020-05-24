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

     ///Returs an array as Results<object>?
    func getObjects<T: Object>(type: T.Type) -> [T]? {
        return realm?.objects(type).toArray(type: type)
    }

//    func getObjects(type: Object.Type) -> Results<Object>? {
//        return realm?.objects(type)
//    }

    ///Save a list object
    func saveListObject(objsArray: [Object]) {
        let objectsRealmList = List<Object>()
        for object in objsArray {
            objectsRealmList.append(object)
        }
        try? realm?.write {
            realm?.add(objectsRealmList)
        }
    }

    ///Remove a list object
    func deleteListObject(objsArray: [Object]) {
        let objectsRealmList = List<Object>()
        for object in objsArray {
            objectsRealmList.append(object)
        }
        try? realm?.write {
            realm?.delete(objectsRealmList)
        }
    }

}
