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
    let downloads: Int?
    
    // MARK: - Helper decod for camelCase standart
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case urls = "urls"
        case user = "user"
        case downloads = "downloads"
    }
}

// MARK: - User
struct User: Codable {
    let name: String
    let location: String?
}

// MARK: - SearchModel
struct SearchModel: Codable {
    let results: [PictureModel]?
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
