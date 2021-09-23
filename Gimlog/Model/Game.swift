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
    let rating: Float
    var description: String?
    var developers: [Developer]?
    var publishers: [Publisher]?
    
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
    
    func getAllDevelopers() -> String? {
        if let devs = developers {
            if !devs.isEmpty {
                return devs.map({$0.name}).joined(separator: ",\n")
            }
        }
        return nil
    }
    
    func getAllPublishers() -> String? {
        if let pubs = publishers {
            if !pubs.isEmpty {
                return pubs.map({$0.name}).joined(separator: ",\n")
            }
        }
        return nil
    }
    
}

struct Developer: Codable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

struct Publisher: Codable {
    let id: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
