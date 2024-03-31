//
//  Tweet.swift
//  CafeMemo
//
//  Created by misaki on 2024/03/10.
//

import Foundation
import RealmSwift

class Tweet: Object {
    @Persisted var tweetText: String?
    @Persisted var tweetImageName: String?
    @Persisted var createdAt: Date?
   /* @Persisted var tweetImageData: Data?*/
    @Persisted var tweetImageURLs = List<String>()
    @Persisted var tweetRating: Int = 0
    @Persisted var rating: Float = 0.0
    @Persisted var latitude: Double = 0.0
    @Persisted var longitude: Double = 0.0
    
}
class MigrationService {
    static func performMigration() {
        let config = Realm.Configuration(
            schemaVersion: 6,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 2 {
                    // スキーマバージョン1から2へのマイグレーション
                    // ここで必要な変更を適用する
                    migration.enumerateObjects(ofType: Tweet.className()) { oldObject, newObject in
                        // 既存のプロパティの名前変更や新しいプロパティの追加などを行う
                        newObject?["id"] = ObjectId.generate()
                    }
                }
                // 2から3、3から4、4から5、5から6へのマイグレーションの処理を追加する
                if oldSchemaVersion < 6 {
                    // スキーマバージョン5から6へのマイグレーション
                    // ここで必要な変更を適用する
                    migration.enumerateObjects(ofType: Tweet.className()) { oldObject, newObject in
                        // 新しいプロパティの追加などを行う
                        newObject?["latitude"] = 0.0
                        newObject?["longitude"] = 0.0
                    }
                }
            }
        )
        Realm.Configuration.defaultConfiguration = config
    }
}

/*class MigrationService {
    static func performMigration() {
        let config = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 2 {
                    // スキーマバージョン1から2へのマイグレーション
                    // ここで必要な変更を適用する
                    migration.enumerateObjects(ofType: Tweet.className()) { oldObject, newObject in
                        // 既存のプロパティの名前変更や新しいプロパティの追加などを行う
                        newObject?["id"] = ObjectId.generate()
                    }
                }
            }
        )
        Realm.Configuration.defaultConfiguration = config
    }
}*/
