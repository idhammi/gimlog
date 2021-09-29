//
//  Game.swift
//  Gimlog
//
//  Created by Idham on 16/09/21.
//

import Foundation

struct GameModel: Codable, Identifiable {
    var id: Int?
    var name: String?
    var released: String?
    var backgroundImage: String?
    var rating: Float?
    var description: String?
    var developers: [DeveloperModel]?
    var publishers: [PublisherModel]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case backgroundImage = "background_image"
        case rating
        case description = "description_raw"
        case developers
        case publishers
    }
    
    func getRatingString() -> String {
        if let rat = rating {
            return String(rat)
        } else {
            return "-"
        }
    }
    
    func getYearReleased() -> String {
        if let year = released {
            return String(year.prefix(4))
        } else {
            return "-"
        }
    }
    
    func getReleasedFormatted() -> String {
        if let releaseDate = released {
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "yyyy-MM-dd"
            let date = dateFormater.date(from: releaseDate)
            dateFormater.dateFormat = "MMM dd, yyyy"
            let timeStr = dateFormater.string(from: date!)
            return timeStr
        } else {
            return "-"
        }
    }
    
    func getAllDevelopers() -> String? {
        if let devs = developers {
            if !devs.isEmpty {
                return devs.map({$0.name ?? ""}).joined(separator: ",\n")
            }
        }
        return nil
    }
    
    func getAllPublishers() -> String? {
        if let pubs = publishers {
            if !pubs.isEmpty {
                return pubs.map({$0.name ?? ""}).joined(separator: ",\n")
            }
        }
        return nil
    }
    
}

struct DeveloperModel: Codable {
    var id: Int?
    var name: String?
}

struct PublisherModel: Codable {
    var id: Int?
    var name: String?
}
