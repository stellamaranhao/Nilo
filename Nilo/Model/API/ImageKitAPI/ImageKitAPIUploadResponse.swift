// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let predictionImageKitUploadResponse = try? newJSONDecoder().decode(predictionImageKitUploadResponse.self, from: jsonData)

import Foundation

// MARK: - predictionImageKitUploadResponse
struct ImageKitUploadResponse: Codable {
    let fileId, name: String?
    let size: Int?
    let versionInfo: predictionVersionInfo?
    let filePath: String?
    let url: String?
    let fileType: String?
    let height, width, orientation: Int?
    let thumbnailUrl: String?
    let aiTags: JSONNull?

    enum CodingKeys: String, CodingKey {
        case fileId, name, size, versionInfo, filePath, url, fileType, height, width, orientation, thumbnailUrl
        case aiTags = "AITags"
    }
}

// MARK: - predictionVersionInfo
struct predictionVersionInfo: Codable {
    let id, name: String?
}
