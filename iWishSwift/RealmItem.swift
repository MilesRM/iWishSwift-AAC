//
//  RealmItem.swift
//  iWishSwift
//
//  Created by andycheng on 2016/11/5.
//  Copyright © 2016年 ccjeng. All rights reserved.
//
import RealmSwift

public class RealmItem: NSObject {
    
    override init() {
        super.init()
        
        let count = self.selectAll().count
        if count == 0 {
            self.add("想去")
            self.add("有去")
            self.add("想吃")
            self.add("有吃")
            self.add("想喝")
            self.add("有喝")
            self.add("想聽")
            self.add("想看")
            self.add("想講電話")
            self.add("帶我去")
            self.add("喜歡")
            self.add("害怕")
        }
    }
    
    func add(_ itemName:String){
        
        let item = Item()
        item.name = itemName
        
        let realm = try! Realm()
        
        try! realm.write {
            if itemName != "" {
                realm.add(item)
            }
        }
    }
    
    func delete(_ id:String) {
        
        let realm = try! Realm()
        let predicate = NSPredicate(format: "id = %@", id)
        let item = realm.objects(Item.self).filter(predicate)
                
        try! realm.write {
            realm.delete(item)
        }
        
    }
    
    func update(_ id:String, _ name:String) {
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.create(Item.self, value: ["id": id, "name": name], update: true)
        }
        
    }
    
    func selectAll() -> Results<Item> {
        
        let realm = try! Realm()
        
        return realm.objects(Item.self).sorted(byProperty:"order")
    }
}
