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
    
    dynamic var id = NSUUID().uuidString
    dynamic var name = ""
    dynamic var order = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
