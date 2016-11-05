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
    
    func add(_ subItemName:String, _ itemId:String){
        
        let subItem = SubItem()
        subItem.name = subItemName
        
        
        let realm = try! Realm()
        
        if subItemName != "" {
            realm.beginWrite()
        
            var item = Item()
            let predicate = NSPredicate(format: "id = %@", itemId)
            item = realm.objects(Item.self).filter(predicate).first!
            item.subItems.append(subItem)
            realm.add(item, update: true)

            try! realm.commitWrite()
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
    
    func selectByItemId(_ itemId:String) -> List<SubItem> {
        
        let realm = try! Realm()
        
        var item = Item()
        let predicate = NSPredicate(format: "id = %@", itemId)
        item = realm.objects(Item.self).filter(predicate).first!
        
        return item.subItems
    }
    

    func initData(_ itemId:String){
    
        let realm = try! Realm()
        let predicate = NSPredicate(format: "id = %@", itemId)
        let item = realm.objects(Item.self).filter(predicate).first!
        
        let subItemCount = self.selectByItemId(itemId).count
        
        if subItemCount == 0  {
            switch(item.name) {
            case "想去","有去":
                self.add("台北101看水舞", itemId)
                self.add("大安森林公園看水舞", itemId)
                self.add("大直美麗華逛街吃東西", itemId)
                self.add("中正紀念堂吃東西看表演", itemId)
                self.add("天母Sogo百貨公司逛街吃東西", itemId)
                self.add("京站逛Zara和Miki的店", itemId)
                self.add("大葉高島屋逛Uniqlo和無印良品", itemId)
                self.add("兒童新樂園吃愛爾蘭瘋薯", itemId)
                break
            case "想吃","有吃":
                self.add("棒棒腿和雞米花", itemId)
                self.add("帕尼尼", itemId)
                self.add("披薩", itemId)
                self.add("墨西哥蓋飯", itemId)
                self.add("麥當勞兒童參", itemId)
                self.add("冰淇淋", itemId)
                self.add("麵", itemId)
                self.add("蛋糕", itemId)
                self.add("點心", itemId)
                self.add("飯", itemId)
                self.add("水果", itemId)
                self.add("爆米花", itemId)
                break
            case "想喝","有喝":
                self.add("水", itemId)
                self.add("果汁", itemId)
                self.add("牛奶", itemId)
                self.add("珍珠奶茶", itemId)
                self.add("紅茶", itemId)
                self.add("咖啡", itemId)
                self.add("豆米漿", itemId)
                self.add("薏仁露", itemId)
                break
            case "想聽":
                self.add("音樂", itemId)
                self.add("故事", itemId)
                break
            case "想看":
                self.add("DVD", itemId)
                self.add("電視卡通", itemId)
                self.add("書本電子書", itemId)
                self.add("故事書", itemId)
                self.add("皮巴弟先生與薛曼的時光冒險", itemId)
                self.add("馴龍高手", itemId)
                self.add("古魯家族", itemId)
                self.add("冰原歷險記", itemId)
                self.add("尖叫旅社", itemId)
                self.add("勇敢傳說", itemId)
                self.add("羅雷斯", itemId)
                self.add("森林戰士", itemId)
                break
            case "想講電話":
                self.add("和舅舅聊天", itemId)
                self.add("和外婆聊天", itemId)
                self.add("找爸爸媽媽", itemId)
                break
            case "帶我去":
                self.add("上廁所", itemId)
                self.add("走一走", itemId)
                self.add("外面玩", itemId)
                break
            case "喜歡":
                self.add("吃好吃的東西", itemId)
                self.add("逛街", itemId)
                self.add("看水舞", itemId)
                self.add("撒嬌", itemId)
                self.add("看DVD", itemId)
                self.add("聽音樂", itemId)
                self.add("聊天講電話", itemId)
                self.add("出去玩出國玩", itemId)
                self.add("看書", itemId)
                self.add("玩玩具", itemId)
                self.add("玩水", itemId)
                self.add("聊服裝品牌", itemId)
                break
            case "害怕":
                self.add("摩托車的聲音", itemId)
                self.add("狗叫的聲音", itemId)
                self.add("大聲說話的聲音", itemId)
                self.add("下雨天沒有水舞", itemId)
                self.add("放鞭炮煙火聲", itemId)
                self.add("黑", itemId)
                self.add("貓咪叫的聲音", itemId)
                self.add("施工的聲音", itemId)
                self.add("嬰兒哭鬧的聲音", itemId)
                self.add("大聲廣播的聲音", itemId)
                break
            default:
                break
            }
        }


    }
}
