//
//  GamesListResponse.swift
//  Gimlog
//
//  Created by Idham on 16/09/21.
//

import Foundation

struct GameListResponse: Codable {
    let count: Int
    let results: [GameModel]
}
