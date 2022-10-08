//
//  ReplicateAPIErro.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 07/10/22.
//

import Foundation


extension ReplicateAPI{
    enum ReplicateError: Error {
        case networkError
        case noInternet
        case invalidToken
        case responseParsingError(response: String)
        case unexpected(message: String)
    }
}
