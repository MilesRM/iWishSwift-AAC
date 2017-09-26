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
            self.add("我很好,謝謝你!")
            self.add("我的名字是鄭至善(善善)")
            self.add("我今年十歲讀五年級")
            self.add("我住在台北市士林區")
            self.add("再見")
            self.add("我喜歡逛街和看水舞")
            self.add("我喜歡吃好吃的東西")
            self.add("我去過很多國家,如英國,紐西蘭")
        }
    }
    
    func add(_ itemName:String){
        
        let item = Introduce()
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
        let item = realm.objects(Introduce.self).filter(predicate)
        
        try! realm.write {
            realm.delete(item)
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
