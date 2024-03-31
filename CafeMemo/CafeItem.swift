//
//  CafeItem.swift
//  CafeMemo
//
//  Created by misaki on 2024/03/05.
//

/*import Foundation
import RealmSwift

class CafeItem: Object {
    @Persisted var name: String = ""
    @Persisted var review: Int = 0
    
    
   /* @Persisted var storeImage: UIImageView!
    @Persisted var osipin: UIImageView!*/
  
    func setImage(image: UIImage?) -> String? {
        // 画像がnilだったらnilを返却して処理から抜ける
        guard let image = image else { return nil }
        // ファイル名をUUIDで生成し、拡張子を".jpeg"にする
        let fileName = UUID().uuidString + ".jpeg"
        // ドキュメントディレクトリのURLを取得
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        // ファイルのURLを作成
        let fileURL = documentsDirectoryURL.appendingPathComponent(fileName)
        // UIImageをJPEGデータに変換
        let data = image.jpegData(compressionQuality: 1.0)
        // JPEGデータをファイルに書き込み
        do {
            try data!.write(to: fileURL)
            print(fileName)
        } catch {
            print("💀エラー")
        }
        return fileName
    }

    
    
    
}*/
