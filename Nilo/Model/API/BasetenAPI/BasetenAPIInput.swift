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
    
    
    func GFPGAN(image:UIImage){
        var json:[String: Any] = [
            //"inputs": [["image_url" : image.dataURL()!]]
            "inputs": [["image_url" : "https://akvis.com/img/examples/retoucher/man-photoshop/source.jpg"]]
        ]
        
        using = BasetenAPIModelEnum.GFPGAN.rawValue
        httpBody = try! JSONSerialization.data(withJSONObject: json)
        print(String(data: httpBody!, encoding: .utf8)!)
    }
    
    
}
