//
//  ReplicateAPIOutput.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 07/10/22.
//

import Foundation
import UIKit

class ReplicateAPIPredictionInfo:Codable{
    let id: String
    let model: ReplicateAPIModelsEnum
    var presented:Bool
    let createdAt: Date
    let getURL: URL
    let cancelURL: URL
    
    init(from givenOutput: ReplicateAPIMakePredictionResponse){
        self.id = givenOutput.id!
        self.model = ReplicateAPIModelsEnum(rawValue: givenOutput.version!)!
        self.presented = false
        self.getURL = URL(string: (givenOutput.urls?.urlsGet)!)!
        self.cancelURL = URL(string: (givenOutput.urls?.cancel)!)!
        self.createdAt = Date()
    }
}
