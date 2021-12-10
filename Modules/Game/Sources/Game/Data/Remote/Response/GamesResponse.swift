//
//  GamesResponse.swift
//  
//
//  Created by Idham on 08/12/21.
//

public struct GamesResponse: Decodable {
    let count: Int
    let results: [GameResponse]
}

public struct GameResponse: Decodable {
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

public struct DeveloperResponse: Decodable {
    let id: Int?
    let name: String?
}

public struct PublisherResponse: Decodable {
    let id: Int?
    let name: String?
}
