//
//  BasetenAPIInput.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 11/10/22.
//

import Foundation
import UIKit

/// Define de Input of de Baseten API
class BasetenAPIInput{
    var using:String?
    var httpBody:Data?
    
    
    /// Sets de BasetenAPIInput to be a GFP-GAN input
    /// - Parameter imageURL: "Image URL hosted in the Internet"
    func GFPGAN(imageURL:String){
        let json:[String: Any] = [
            "inputs": [["image_url" : imageURL]]
        ]
        
        using = BasetenAPIModelEnum.GFPGAN.rawValue
        httpBody = try! JSONSerialization.data(withJSONObject: json)
    }
    
    
}
