//
//  Model.swift
//  DemoApp
//
//  Created by Shabir Jan on 3/10/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import Foundation
import RealmSwift
class Element: Object {
    
    @objc dynamic var title = ""
    @objc dynamic var elementDescription = ""
    @objc dynamic var photoURL:String?
    
    convenience required init(row: [String]) {
        self.init()
        self.title = row[0]
        self.elementDescription = row[1]
        self.photoURL = row[2]
        
    }
}
