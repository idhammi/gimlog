//
//  GameEntity.swift
//  Gimlog
//
//  Created by Idham on 19/11/21.
//

import Foundation
import RealmSwift

class GameEntity: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var released: String = ""
    @objc dynamic var backgroundImage: String = ""
    @objc dynamic var rating: Float = 0.0
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}
