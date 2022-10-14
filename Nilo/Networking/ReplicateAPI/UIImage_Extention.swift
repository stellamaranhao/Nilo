//
//  Gambs.swift
//  Nilo
//
//  Created by Clara Thaís Maciel e Silva on 06/10/22.
//

import Foundation
import UIKit

extension UIImage {
    
    /// Check if image has alpha
    /// - Returns: Boolean if image has alpha
    func hasAlpha() -> Bool {
        guard let cgImage = cgImage else {
            return false
        }
        let alpha = cgImage.alphaInfo
        return alpha == .first || alpha == .last || alpha == .premultipliedFirst || alpha == .premultipliedLast
    }
    
    /// Convert UIimage to dataURL (formatted)
    /// - Returns: dataURL
    func dataURL() -> String? {
        var imageData: Data? = nil
        var mimeType: String? = nil
        
        if hasAlpha() {
            imageData = self.pngData()
            mimeType = "image/png"
        } else {
            imageData = self.jpegData(compressionQuality: 1.0)
            mimeType = "image/jpeg"
        }
        
        return "data:\(mimeType ?? "");base64,\(imageData?.base64EncodedString(options: []) ?? "")"
    }
}


