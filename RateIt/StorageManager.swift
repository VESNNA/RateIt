//
//  StorageManager.swift
//  RateIt
//
//  Created by Nikita Vesna on 17.04.2020.
//  Copyright © 2020 Nikita Vesna. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveObject(_ review: Review) {
        try! realm.write{
            realm.add(review)
        }
    }
    
    static func deleteObject(_ review: Review) {
        try! realm.write{
            realm.delete(review)
        }
    }
}

