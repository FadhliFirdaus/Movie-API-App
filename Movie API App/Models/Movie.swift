//
//  Movie.swift
//  Movie API App
//
//  Created by Fadhli Firdaus on 06/03/2024.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

    // MARK: - Main Response


struct MainResponse: Codable {
    let entries: Int
    let results: [Movie]
    let next: String
    let page: Int
}

    // MARK: - Result
struct Movie: Codable, Hashable, Equatable {
    let id: String
    let titleText: TitleText
    let releaseYear: ReleaseYear
    let resultID: String
    let titleType: TitleType
    let primaryImage: PrimaryImage?
    let releaseDate: ReleaseDate?
    let originalTitleText: TitleText
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case titleText, releaseYear
        case resultID = "id"
        case titleType, primaryImage, releaseDate, originalTitleText
    }
}

    // MARK: - TitleText
struct TitleText: Codable, Equatable, Hashable {
    let text: String
    let typename: OriginalTitleTextTypename
    
    enum CodingKeys: String, CodingKey {
        case text
        case typename = "__typename"
    }
}

enum OriginalTitleTextTypename: String, Codable, Equatable, Hashable {
    case titleText = "TitleText"
}

    // MARK: - PrimaryImage
struct PrimaryImage: Codable,Equatable, Hashable {
    let id, typename: String
    let caption: Caption
    let width, height: Int
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case typename = "__typename"
        case caption, width, height, url
    }
}

    // MARK: - Caption
struct Caption: Codable,Equatable, Hashable {
    let typename, plainText: String
    
    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case plainText
    }
}

    // MARK: - ReleaseDate
struct ReleaseDate: Codable, Equatable, Hashable {
    let typename: String
    let day: JSONNull?
    let month: Int?
    let year: Int
    
    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case day, month, year
    }
}

    // MARK: - ReleaseYear
struct ReleaseYear: Codable, Equatable, Hashable {
    let year: Int
    let endYear: JSONNull?
    let typename: ReleaseYearTypename
    
    enum CodingKeys: String, CodingKey {
        case year, endYear
        case typename = "__typename"
    }
}

enum ReleaseYearTypename: String, Codable, Equatable, Hashable {
    case yearRange = "YearRange"
}

    // MARK: - TitleType
struct TitleType: Codable, Equatable, Hashable {
    let isEpisode: Bool
    let id: ID
    let typename: TitleTypeTypename
    let isSeries: Bool
    let text: Texta
    
    enum CodingKeys: String, CodingKey {
        case isEpisode, id
        case typename = "__typename"
        case isSeries, text
    }
}

enum ID: String, Codable {
    case short = "short"
}

enum Texta: String, Codable {
    case short = "Short"
}

enum TitleTypeTypename: String, Codable {
    case titleType = "TitleType"
}

    // MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    func hash(into hasher: inout Hasher) {
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

let mockMovieData: Movie = Movie(
    id: "123456",
    titleText: TitleText(text: "Mock Movie", typename: .titleText),
    releaseYear: ReleaseYear(year: 2022, endYear: nil, typename: .yearRange),
    resultID: "789012",
    titleType: TitleType(isEpisode: false, id: .short, typename: .titleType, isSeries: false, text: .short),
    primaryImage: PrimaryImage(id: "image123", typename: "__typename", caption: Caption(typename: "__typename", plainText: "Mock Caption"), width: 800, height: 600, url: "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg"),
    releaseDate: ReleaseDate(typename: "__typename", day: nil, month: 1, year: 2022),
    originalTitleText: TitleText(text: "Original Title", typename: .titleText)
)
