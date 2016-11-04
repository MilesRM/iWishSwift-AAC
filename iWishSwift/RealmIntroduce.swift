//
//  RealmIntroduce.swift
//  iWishSwift
//
//  Created by andycheng on 2016/11/4.
//  Copyright © 2016年 ccjeng. All rights reserved.
//
import RealmSwift

public class RealmIntroduce: NSObject {
    
    override init() {
        super.init()
        
        let count = self.selectAll().count
        if count == 0 {
            self.add("1")
            self.add("2")
            self.add("3")
            self.add("4")
            self.add("5")
            self.add("6")
            self.add("7")
        }
    }
    
    func add(_ itemName:String){
        
        let item = Introduce()
        item.name = itemName
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(item)
        }
    }
    
    func delete(_ id:String) {
        
        let realm = try! Realm()
        let predicate = NSPredicate(format: "id = %@", id)
        let category = realm.objects(Introduce.self).filter(predicate)
        
        try! realm.write {
            realm.delete(category)
        }
        
    }
    
    func update(_ id:String, _ name:String) {
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.create(Introduce.self, value: ["id": id, "name": name], update: true)
        }
        
    }
    
    func selectAll() -> Results<Introduce> {
        
        let realm = try! Realm()
        
        return realm.objects(Introduce.self).sorted(byProperty:"order")
    }
}
