//
//  APIProtocol.swift
//  Nilo
//
//  Created by Stella Maranhao on 27/10/22.
//

import Foundation
import AVFoundation
protocol APIProtocol{
    var algorithm:APIAlgorithm {get}
    func predictImage(fromImage image:UIImage,onCompletion completionCallback:@escaping(Result<UIImage,Error>)->Void)
    func predictVideo(fromImage image:UIImage,onCompletion completionCallback:@escaping(Result<TemporaryMediaFile,Error>)->Void)
    func checkConnectionHealth()->Bool
    func cancelImage()
}

enum APIAlgorithm {
    case GFPGAN
    case colorizeML
    case firstOrderModel
}
