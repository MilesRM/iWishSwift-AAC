//
//  RealmCategory.swift
//  iWishSwift
//
//  Created by andycheng on 2016/11/4.
//  Copyright © 2016年 ccjeng. All rights reserved.
//

import RealmSwift

public class RealmCategory: NSObject {
    
    override init() {
        super.init()
        
        let count = self.selectAll().count
        if count == 0 {
            self.add("你")
            self.add("我")
            self.add("他")
            self.add("請幫忙")
            self.add("爸爸媽媽")
            self.add("老師")
            self.add("外婆")
            self.add("舅舅")
            self.add("爺爺奶奶")
            self.add("謝謝你")
            self.add("你好")
            self.add("早安(午安,晚安)")
        }
    }
    
    @objc func add(_ itemName:String){
        
        let item = Category()
        item.name = itemName
    
        let realm = try! Realm()

        try! realm.write {
            if itemName != "" {
                realm.add(item)
            }
        }
    }
    
    @objc func delete(_ id:String) {
        
        let realm = try! Realm()
        let predicate = NSPredicate(format: "id = %@", id)
        let item = realm.objects(Category.self).filter(predicate)
        
        try! realm.write {
            realm.delete(item)
        }
        
    }
    
    @objc func update(_ id:String, _ name:String) {
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.create(Category.self, value: ["id": id, "name": name], update: true)
        }
        
    }
    
    func selectAll() -> Results<Category> {
        
        let realm = try! Realm()

        return realm.objects(Category.self).sorted(byKeyPath:"order")
    }
}
