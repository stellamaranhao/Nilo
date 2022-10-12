
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let replicatePredictionInfoResponse = try? newJSONDecoder().decode(ReplicatePredictionInfoResponse.self, from: jsonData)

import Foundation

// MARK: - ReplicateAPIPredictionResponse
struct ReplicateAPIMakePredictionResponse: Codable {
    var id, version: String?
    var urls: predictionUrls?
    var createdAt, startedAt, completedAt, status: String?
    var input: predictionInput?
    var output, error, logs: String?
    var metrics: predictionInput?

    enum CodingKeys: String, CodingKey {
        case id, version, urls
        case createdAt = "created_at"
        case startedAt = "started_at"
        case completedAt = "completed_at"
        case status, input, output, error, logs, metrics
    }
}

// MARK: - predictionInput
struct predictionInput: Codable {
}

// MARK: - predictionUrls
struct predictionUrls: Codable {
    var urlsGet, cancel: String?

    enum CodingKeys: String, CodingKey {
        case urlsGet = "get"
        case cancel
    }
}
