//
//  image.swift
//  CafeMemo
//
//  Created by misaki on 2024/03/10.
//

import Foundation
import UIKit
//グローバルに関数を書いた時のファイル、今回は使用せずに実装している。
//画像を取得する関数
func getImage(tweetImageURL: String?) -> UIImage?{
    // 画像のパスを取得
    if let tweetImageName = tweetImageURL {
        let path = getImageURL(fileName: tweetImageName).path
        if FileManager.default.fileExists(atPath: path) { //pathにファイルが存在しているかチェック
            if let imageData = UIImage(contentsOfFile: path) {  //pathに保存されている画像を取得
                return imageData
            } else {
                print("Failed to load the image. path = ", path)
            }
        } else {
            print("Image file not found. path = ", path)
        }
    }
    return nil
}
func getImageURL(fileName: String) -> URL {
    let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    return docDir.appendingPathComponent(fileName)
}

// 画像を保存するメソッド
func saveImage(image: UIImage) -> String? {
    guard let imageData = image.jpegData(compressionQuality: 1.0) else { return nil }

    do {
        let fileName = UUID().uuidString + ".jpeg" // ファイル名を決定(UUIDは、ユニークなID)
        let imageURL = getImageURL(fileName: fileName) // 保存先のURLをゲット
        try imageData.write(to: imageURL) // imageURLに画像を書き込む
        return fileName
    } catch {
        print("Failed to save the image:", error)
        return nil
    }
}
