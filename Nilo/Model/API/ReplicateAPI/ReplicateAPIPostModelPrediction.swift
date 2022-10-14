// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let replicateAPIPostModelPrediction = try? newJSONDecoder().decode(ReplicateAPIPostModelPrediction.self, from: jsonData)

import Foundation

// MARK: - ReplicateAPIPostModelPrediction
struct ReplicateAPIPostModelPrediction: Codable {
    let id, version: String?
    let urls: Urls?
    let createdAt: String?
    let startedAt, completedAt: JSONNull?
    let status: String?
    let input: Input?
    let output, error, logs: JSONNull?
    let metrics: Metrics?

    enum CodingKeys: String, CodingKey {
        case id, version, urls
        case createdAt = "created_at"
        case startedAt = "started_at"
        case completedAt = "completed_at"
        case status, input, output, error, logs, metrics
    }
}

// MARK: - Input
struct Input: Codable {
    let text: String?
}

// MARK: - Metrics
struct Metrics: Codable {
}

// MARK: - Urls
struct Urls: Codable {
    let urlsGet, cancel: String?

    enum CodingKeys: String, CodingKey {
        case urlsGet = "get"
        case cancel
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
