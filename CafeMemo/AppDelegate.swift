//
//  AppDelegate.swift
//  CafeMemo
//
//  Created by misaki on 2024/02/26.
//

/*import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let config = Realm.Configuration(schemaVersion: 1)
        Realm.Configuration.defaultConfiguration = config
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}*/

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        MigrationService.performMigration()
               
               return true
       /*let config = Realm.Configuration(
                    schemaVersion: 2, // 以前のスキーマバージョンに戻す
                    migrationBlock: { migration, oldSchemaVersion in
                        // 何もしない
                    })
                Realm.Configuration.defaultConfiguration = config
                
                return true*/
        // 新しいスキーマバージョンを指定
       /* let config = Realm.Configuration(
            schemaVersion: 2, // 新しいスキーマのバージョン
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 2) {
                    // マイグレーション処理を実装
                    // 例: migration.enumerateObjects(ofType: Tweet.className()) { oldObject, newObject in
                    //     newObject?["createdAt"] = Date()
                    // }
                }
            })
        
        // Realmのデフォルト設定を変更
        Realm.Configuration.defaultConfiguration = config
        
        return true*/
    
    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
 
/*import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Realmのデフォルト設定を変更
        let config = Realm.Configuration(
            schemaVersion: 3, // 新しいスキーマのバージョン
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 3 {
                    // 'rating' プロパティの追加
                    migration.enumerateObjects(ofType: Tweet.className()) { oldObject, newObject in
                        newObject?["rating"] = 0 // デフォルト値などを設定
                    }
                }
            })
        Realm.Configuration.defaultConfiguration = config
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}*/




