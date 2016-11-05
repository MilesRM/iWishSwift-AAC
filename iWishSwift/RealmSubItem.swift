//
//  RealmSubItem.swift
//  iWishSwift
//
//  Created by andycheng on 2016/11/5.
//  Copyright © 2016年 ccjeng. All rights reserved.
//
import RealmSwift

public class RealmSubItem: NSObject {
    
    override init() {
        super.init()
    }
    
    func add(_ itemName:String){
        
        let item = Item()
        item.name = itemName
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(item)
        }
    }
    
    func delete(_ id:String) {
        
        let realm = try! Realm()
        let predicate = NSPredicate(format: "id = %@", id)
        let item = realm.objects(SubItem.self).filter(predicate)
        
        try! realm.write {
            realm.delete(item)
        }
        
    }
    
    func update(_ id:String, _ name:String) {
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.create(SubItem.self, value: ["id": id, "name": name], update: true)
        }
        
    }
    
    func selectAll() -> Results<SubItem> {
        
        let realm = try! Realm()
        
        return realm.objects(SubItem.self)//.sorted(byProperty:"order")
    }
}
