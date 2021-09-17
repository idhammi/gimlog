//
//  Game.swift
//  Gimlog
//
//  Created by Idham on 16/09/21.
//

import UIKit

struct Game: Codable, Identifiable {
    let id: Int
    let name: String
    let released: String
    let backgroundImage: String
    var description: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case backgroundImage = "background_image"
        case description = "description_raw"
    }
}

