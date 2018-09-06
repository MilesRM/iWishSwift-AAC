//
//  Story.swift
//  iWishSwift
//
//  Created by andycheng on 2018/9/6.
//  Copyright © 2018年 ccjeng. All rights reserved.
//

import Foundation
import RealmSwift

class Story: Object {
    @objc dynamic var id = NSUUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var datetime = NSDate()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
