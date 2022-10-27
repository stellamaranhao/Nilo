//
//  APIProtocol.swift
//  Nilo
//
//  Created by Stella Maranhao on 27/10/22.
//

import Foundation
protocol APIProtocol{
    func predictImage(fromImage image:UIImage,onCompletion completionCallback:@escaping(Result<UIImage,Error>)->Void)
    
    
    
}
