//
//  RealmSelection.swift
//  iWishSwift
//
//  Created by andycheng on 2016/11/4.
//  Copyright © 2016年 ccjeng. All rights reserved.
//
import RealmSwift

public class RealmSelection: NSObject {
    
    override init() {
        super.init()
        
        let count = self.selectAll().count
        if count == 0 {
            self.add("是")
            self.add("不是")
            self.add("對")
            self.add("不對")
            self.add("好")
            self.add("不好")
            self.add("不知道?")
            self.add("不確定?")
            self.add("有")
            self.add("沒有")
            self.add("喜歡")
            self.add("不喜歡")
        }
    }
    
    func add(_ itemName:String){
        
        let item = Selection()
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
        let item = realm.objects(Selection.self).filter(predicate)
        
        try! realm.write {
            realm.delete(item)
        }
        
    }
    
    func update(_ id:String, _ name:String) {
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.create(Selection.self, value: ["id": id, "name": name], update: true)
        }
        
    }
    
    func selectAll() -> Results<Selection> {
        
        let realm = try! Realm()
        
        return realm.objects(Selection.self).sorted(byProperty:"order")
    }
}
