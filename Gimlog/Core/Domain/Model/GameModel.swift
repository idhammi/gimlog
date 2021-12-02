//
//  Game.swift
//  Gimlog
//
//  Created by Idham on 16/09/21.
//

import Foundation

struct GameModel: Equatable, Identifiable {
    
    static func == (lhs: GameModel, rhs: GameModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: Int
    let name: String
    let released: String
    let backgroundImage: String
    let rating: Float
    var description: String?
    var developers: [DeveloperModel]?
    var publishers: [PublisherModel]?
    
    func getYearReleased() -> String {
        String(released.prefix(4))
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

struct DeveloperModel: Equatable, Identifiable {
    let id: Int
    let name: String?
}

struct PublisherModel: Equatable, Identifiable {
    let id: Int
    let name: String?
}
