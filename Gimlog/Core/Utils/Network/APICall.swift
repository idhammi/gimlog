//
//  APICall.swift
//  Gimlog
//
//  Created by Idham on 19/11/21.
//

import Foundation

struct API {
    
    static let baseUrl = "https://api.rawg.io/api"
    static let apiKey = "5812fa28905c43af81a543cacd12a74b"
    
}

struct Endpoints {
    
    static func getGames() -> String {
        return "\(API.baseUrl)/games"
    }
    
    static func getGameDetail(gameId: Int) -> String {
        return "\(API.baseUrl)/games/\(gameId)"
    }
    
}
