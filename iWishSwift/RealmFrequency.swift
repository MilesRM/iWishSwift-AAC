//
//  RealmCategory.swift
//  iWishSwift
//
//  Created by andycheng on 2016/11/4.
//  Copyright © 2016年 ccjeng. All rights reserved.
//

import RealmSwift

public class RealmFrequency: NSObject {
    
    override init() {
        super.init()
        
        let count = self.selectAll().count
        if count == 0 {
            self.add("我想要上廁所")
            self.add("我想要喝水")
            self.add("我想要吃東西")
            self.add("我想要休息")
            self.add("我想要玩耍(看書/聽音樂/看DVD)")
            self.add("請問你的衣服是什麼牌子的?")
            self.add("請問你的其他衣物(用手指出)是什麼牌子的?")
        }
    }
    
    func add(_ itemName:String){
        
        let item = Frequency()
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
        let item = realm.objects(Frequency.self).filter(predicate)
        
        try! realm.write {
            realm.delete(item)
        }
        
    }
    
    func update(_ id:String, _ name:String) {
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.create(Frequency.self, value: ["id": id, "name": name], update: true)
        }
        
    }
    
    func selectAll() -> Results<Frequency> {
        
        let realm = try! Realm()
        
        return realm.objects(Frequency.self).sorted(byProperty:"order")
    }
}
