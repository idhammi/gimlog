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
    var description: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case backgroundImage = "background_image"
        case description = "description_raw"
    }
    
    func getYearReleased() -> String {
        return String(released.prefix(4))
    }
    
    func getReleasedFormatted() -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let date = dateFormater.date(from: released)
        dateFormater.dateFormat = "MMM dd, yyyy"
        let timeStr = dateFormater.string(from: date!)
        return timeStr
    }
}
