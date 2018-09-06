//
//  RealmStory.swift
//  iWishSwift
//
//  Created by andycheng on 2018/9/6.
//  Copyright © 2018年 ccjeng. All rights reserved.
//

import RealmSwift

public class RealmStory: NSObject {
    
    override init() {
        super.init()
    }
    
    @objc func add(_ itemName:String){
        
        let item = Story()
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
        let item = realm.objects(Story.self).filter(predicate)
        
        try! realm.write {
            realm.delete(item)
        }
        
    }
    
    @objc func update(_ id:String, _ name:String) {
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.create(Story.self, value: ["id": id, "name": name], update: true)
        }
        
    }
    
    func selectAll() -> Results<Story> {
        
        let realm = try! Realm()
        
        return realm.objects(Story.self).sorted(byKeyPath:"datetime", ascending: false)
    }
}
