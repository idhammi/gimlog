//
//  GameModel.swift
//  
//
//  Created by Idham on 08/12/21.
//

import Foundation

public struct GameModel: Equatable, Identifiable {
    
    public let id: Int
    public let name: String
    public var released: String = ""
    public var backgroundImage: String = ""
    public var rating: Float = 0.0
    public var description: String = ""
    public var developers: [DeveloperModel] = []
    public var publishers: [PublisherModel] = []
    public var favorite: Bool = false
    
    public func getYearReleased() -> String {
        String(released.prefix(4))
    }
    
    public func getReleasedFormatted() -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let date = dateFormater.date(from: released)
        dateFormater.dateFormat = "MMM dd, yyyy"
        let timeStr = dateFormater.string(from: date!)
        return timeStr
    }
    
    public func getAllDevelopers() -> String {
        if !developers.isEmpty {
            return developers.map({$0.name }).joined(separator: ",\n")
        }
        return ""
    }
    
    public func getAllPublishers() -> String {
        if !publishers.isEmpty {
            return publishers.map({$0.name }).joined(separator: ",\n")
        }
        return ""
    }
    
}

public struct DeveloperModel: Equatable, Identifiable {
    public let id: Int
    public let name: String
}

public struct PublisherModel: Equatable, Identifiable {
    public let id: Int
    public let name: String
}
