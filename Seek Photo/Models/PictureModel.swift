//
//  PictureModel.swift
//  Seek Photo
//
//  Created by BSergio on 03.05.2022.
//

// MARK: - Main model
struct PictureModel: Codable {
    let id: String
    let createdAt: String
    let urls: Urls
    let location: Location
    let downloads: Int
    
    // MARK: - Helper decod for camelCase standart
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt = "created_at"
        case urls = "urls"
        case location = "location"
        case downloads = "downloads"
    }
}

// MARK: - Location
struct Location: Codable {
    let city: String?
}

// MARK: - Urls
struct Urls: Codable {
    let small: String
}
