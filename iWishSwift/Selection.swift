//
//  Selection.swift
//  iWishSwift
//
//  Created by andycheng on 2016/11/4.
//  Copyright © 2016年 ccjeng. All rights reserved.
//
import Foundation
import RealmSwift

class Selection: Object {
    
    @objc dynamic var id = NSUUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var order = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
