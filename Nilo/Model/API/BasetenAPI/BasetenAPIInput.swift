//
//  BasetenAPIInput.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 11/10/22.
//

import Foundation
import UIKit

class BasetenAPIInput{
    var using:String?
    var httpBody:Data?
    
    
    func GFPGAN(imageURL:String){
        let json:[String: Any] = [
            "inputs": [["image_url" : imageURL]]
        ]
        
        using = BasetenAPIModelEnum.GFPGAN.rawValue
        httpBody = try! JSONSerialization.data(withJSONObject: json)
    }
    
    
}
