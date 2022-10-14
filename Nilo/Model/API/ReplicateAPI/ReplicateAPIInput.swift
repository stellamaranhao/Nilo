//
//  ReplicateAPICreatePrediction.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 07/10/22.
//

import Foundation
import UIKit

class ReplicateAPIInput{
    var using:ReplicateAPIModelsEnum?
    var httpBody:Data?
    
    init(){
        
    }
    
    func GFPGAN(image:UIImage,version:String,scaleFactor:Float){
        
        var json:[String: Any] = [
            "version": ReplicateAPIModelsEnum.GFPGAN.rawValue,
            "input": ["img":image.dataURL()!,
                      "version":version,
                      "scale":"\(scaleFactor)"]
        ]
        using = ReplicateAPIModelsEnum.GFPGAN
        httpBody = try! JSONSerialization.data(withJSONObject: json)
        
    }
    
}
