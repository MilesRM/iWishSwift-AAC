//
//  Daily.swift
//  iWishSwift
//
//  Created by andycheng on 2016/11/4.
//  Copyright © 2016年 ccjeng. All rights reserved.
//

import Foundation
import RealmSwift

class Daily: Object {
    dynamic var id = NSUUID().uuidString
    dynamic var name = ""
    dynamic var datetime = NSDate()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
