//
//  BasetenError.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 12/10/22.
//

import Foundation

enum BasetenError:Error{
    case badRequestedUrl(response:String)
    case noResponse(response:String)
    case networkError(response:String)
    case invalidReResponseObj(response:String)
    case responseJsonParseError(response:String)
    case pipelineError(response:String)
    case imageKitError(response:String)
}
