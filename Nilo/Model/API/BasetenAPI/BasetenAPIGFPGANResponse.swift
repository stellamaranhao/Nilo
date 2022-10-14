//
//  BasetenAPIGFPGANResponse.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 12/10/22.
//

import Foundation

struct BasetenAPIGFPGANResponse: Codable {
    let modelId, modelVersionId: String?
    let predictions: [String]?

    enum CodingKeys: String, CodingKey {
        case modelId = "model_id"
        case modelVersionId = "model_version_id"
        case predictions
    }
}
