//
//  SubItem.swift
//  iWishSwift
//
//  Created by andycheng on 2016/10/22.
//  Copyright © 2016年 ccjeng. All rights reserved.
//
import Foundation
import RealmSwift

class SubItem: Object {
    
    dynamic var id = NSUUID().uuidString
    dynamic var name = ""

    override static func primaryKey() -> String? {
        return "id"
    }
}
