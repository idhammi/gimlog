//
//  APICall.swift
//  Gimlog
//
//  Created by Idham on 19/11/21.
//

import Foundation

struct API {
    
    static let baseUrl = "https://api.rawg.io/api"
    
    static func getApiKey() -> String {
        guard let filePath = Bundle.main.path(forResource: "Rawg-Info", ofType: "plist") else {
            fatalError("Couldn't find file 'Rawg-Info.plist'.")
        }
        
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'Rawg-Info.plist'.")
        }
        return value
    }

}

struct Endpoints {
    
    static func getGames() -> String {
        return "\(API.baseUrl)/games"
    }
    
    static func getGameDetail() -> String {
        return "\(API.baseUrl)/games/"
    }
    
}
