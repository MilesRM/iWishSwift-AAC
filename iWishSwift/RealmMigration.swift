//
//  RealmMigration.swift
//  iWishSwift
//
//  Created by andycheng on 2018/9/6.
//  Copyright © 2018年 ccjeng. All rights reserved.
//

import Foundation
import RealmSwift

class RealmMigration {
    
    
    func didApplicationLunch () {
        self.migrationVersion()
    }
    
    func migrationVersion() {
        
        
        let config = Realm.Configuration(
            
            schemaVersion : 1 ,
            
            migrationBlock : { migration , oldSchemaVersion in
                
                                if (oldSchemaVersion < 1) {
                                    migration.create(Story.className())
                                }
                
        }
            
        )
        
        Realm.Configuration.defaultConfiguration = config
        
    }
    
}

let realm = try! Realm()

