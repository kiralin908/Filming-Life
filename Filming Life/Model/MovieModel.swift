//
//  MovieModel.swift
//  Filming Life
//
//  Created by 林郁琦 on 2024/5/22.
//


import Foundation

// MARK: - FilmResponse
struct FilmResponse: Codable {
    let records: [Record]
}

// MARK: - Record
struct Record: Codable {
    let id, createdTime: String
    let fields: Fields
}

// MARK: - Fields
struct Fields: Codable {
    let movieTitle, jobTitle: String
    let moviePosteImageName: [MoviePosteImageName]
    let trailerURLName: String
    let infoName, movieTime: String

    enum CodingKeys: String, CodingKey {
        case movieTitle = "MovieTitle"
        case jobTitle = "JobTitle"
        case moviePosteImageName = "MoviePosteImageName"
        case trailerURLName = "TrailerUrlName"
        case infoName = "InfoName"
        case movieTime = "MovieTime"
    }
}

// MARK: - MoviePosteImageName
struct MoviePosteImageName: Codable {
    let id: String
    let width, height: Int
    let url: URL
    let filename: String
    let size: Int
    let type: TypeEnum
    let thumbnails: Thumbnails
}

// MARK: - Thumbnails
struct Thumbnails: Codable {
    let small, large, full: Full
}

// MARK: - Full
struct Full: Codable {
    let url: URL
    let width, height: Int
}

enum TypeEnum: String, Codable {
    case imageJPEG = "image/jpeg"
}
