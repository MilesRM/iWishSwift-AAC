//
//  RealmCategory.swift
//  iWishSwift
//
//  Created by andycheng on 2016/11/4.
//  Copyright © 2016年 ccjeng. All rights reserved.
//

import UIKit
import RealmSwift

public class RealmCategory: NSObject {
    
    override init() {
        super.init()
        
        let count = self.SelectAll_Category().count
        if count == 0 {
            self.Insert_Category("1")
            self.Insert_Category("2")
            self.Insert_Category("3")
            self.Insert_Category("4")
            self.Insert_Category("5")
            self.Insert_Category("6")
            self.Insert_Category("7")
        }
    }
    
    func Insert_Category(_ itemName:String){
        
        let item = Category()
        item.name = itemName
    
        let realm = try! Realm()

        try! realm.write {
            realm.add(item)
        }
    }
    
    func Delete_Category(_ id:String) {
        
        let realm = try! Realm()
        let predicate = NSPredicate(format: "id = %@", id)
        let category = realm.objects(Category.self).filter(predicate)
        
        try! realm.write {
            realm.delete(category)
        }
        
    }
    
    func Update_Category(_ id:String, _ name:String) {
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.create(Category.self, value: ["id": id, "name": name], update: true)
        }
        
    }
    
    func SelectAll_Category() -> Results<Category> {
        
        let realm = try! Realm()

        return realm.objects(Category.self)
    }
}
