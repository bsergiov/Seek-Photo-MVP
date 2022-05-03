//
//  PictureModel.swift
//  Seek Photo
//
//  Created by BSergio on 03.05.2022.
//

// MARK: - Main model
struct PictureModel: Codable {
    let createdAt: String
    let urls: Urls
    let user: User
    let location: Location
    let downloads: Int
    
    // MARK: - Helper decod for camelCase standart
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case urls = "urls"
        case user = "user"
        case location = "location"
        case downloads = "downloads"
    }
}

// MARK: - User
struct User: Codable {
    let name: String
}

// MARK: - SearchModel
struct SearchModel: Codable {
    let results: [PictureModel]?
}

// MARK: - Location
struct Location: Codable {
    let city: String?
}

// MARK: - Urls
struct Urls: Codable {
    let small: String
    let smallS3: String
    let thumb: String
    
    // MARK: - Helper decod for camelCase standart
    enum CodingKeys: String, CodingKey {
        case small = "small"
        case thumb = "thumb"
        case smallS3 = "small_s3"
    }
}
