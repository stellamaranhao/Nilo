//
//  NiloMLError.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 26/10/22.
//

import Foundation

enum NiloMLError: Error {
    //No server was founded in the pool
    case noServerInPool

    // Throw in all other cases
    case unexpected(code: Int)
}
