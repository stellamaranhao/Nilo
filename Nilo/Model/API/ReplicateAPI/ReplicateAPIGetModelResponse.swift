//
//  ReplicateAPIGetModelResponse.swift
//  Nilo
//
//  Created by Clara Thaís Maciel e Silva on 04/10/22.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let replicateAPIGetModelResponse = try? newJSONDecoder().decode(ReplicateAPIGetModelResponse.self, from: jsonData)

import Foundation

// MARK: - ReplicateAPIGetModelResponse
struct ReplicateAPIGetModelResponse: Codable {
    let url: String?
    let owner, name, replicateAPIGetModelResponseDescription, visibility: String?
    let githubURL: String?
    let paperURL, licenseURL: String?
    let latestVersion: LatestVersion?

    enum CodingKeys: String, CodingKey {
        case url, owner, name
        case replicateAPIGetModelResponseDescription = "description"
        case visibility
        case githubURL = "github_url"
        case paperURL = "paper_url"
        case licenseURL = "license_url"
        case latestVersion = "latest_version"
    }
}

// MARK: - LatestVersion
struct LatestVersion: Codable {
}
