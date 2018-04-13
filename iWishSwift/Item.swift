//
//  Item.swift
//  iWishSwift
//
//  Created by andycheng on 2016/10/22.
//  Copyright © 2016年 ccjeng. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var id = NSUUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var order = 0
    let subItems = List<SubItem>()
    
    override static func primaryKey() -> String? {
        return "id"
    }

}
