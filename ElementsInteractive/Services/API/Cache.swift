//
//  CSVCache.swift
//  ElementsInteractive
//
//  Created by Shabir Jan on 3/20/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import Foundation
import RealmSwift

class Cache {
    func setObjects<T: Object>(objects:[T]) {
        DispatchQueue.main.async {
            let realm = try! Realm()
            let olds = realm.objects(T.self)
            try! realm.write {
                realm.delete(olds)
                realm.add(objects, update: false)
            }
        }
    }
    func getObjects<T: Object>(_ completion:@escaping ([T])->Void) {
        DispatchQueue.main.async {
            let realm = try! Realm()
            let objects = realm.objects(T.self)
            completion(Array(objects))
        }
    }
}
