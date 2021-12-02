//
//  GamesListResponse.swift
//  Gimlog
//
//  Created by Idham on 16/09/21.
//

struct GamesResponse: Decodable {
    let count: Int
    let results: [GameResponse]
}

struct GameResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case backgroundImage = "background_image"
        case rating
        case description = "description_raw"
        case developers
        case publishers
    }
    
    let id: Int?
    let name: String?
    let released: String?
    let backgroundImage: String?
    let rating: Float?
    let description: String?
    let developers: [DeveloperResponse]?
    let publishers: [PublisherResponse]?
}

struct DeveloperResponse: Decodable {
    let id: Int?
    let name: String?
}

struct PublisherResponse: Decodable {
    let id: Int?
    let name: String?
}
