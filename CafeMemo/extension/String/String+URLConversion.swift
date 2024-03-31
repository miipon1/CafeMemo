import Foundation
import UIKit

extension String {
    func convertStringToURL() -> URL {
        let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docDir.appendingPathComponent(self)
    }
}
