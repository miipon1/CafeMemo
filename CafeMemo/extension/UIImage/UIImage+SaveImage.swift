import Foundation
import UIKit

extension UIImage {
    func saveImage(imageURL:URL, fileName: String) -> String? {
        guard let imageData = self.jpegData(compressionQuality: 1.0) else { return nil }
        do {
            try imageData.write(to: imageURL) // imageURLに画像を書き込む
            return fileName
        } catch {
            print("Failed to save the image:", error)
            return nil
        }
    }
}
