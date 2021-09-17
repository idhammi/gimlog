//
//  GamesListResponse.swift
//  Gimlog
//
//  Created by Idham on 16/09/21.
//

import UIKit

struct GameListResponse: Codable {
    let count: Int
    let results: [Game]
    
    enum CodingKeys: String, CodingKey {
        case count
        case results
    }
}
