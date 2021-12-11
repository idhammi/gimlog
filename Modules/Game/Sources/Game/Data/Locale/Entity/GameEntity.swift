//
//  GameEntity.swift
//  
//
//  Created by Idham on 08/12/21.
//

import Foundation
import RealmSwift

public class GameEntity: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var released: String = ""
    @objc dynamic var backgroundImage: String = ""
    @objc dynamic var rating: Float = 0.0
    @objc dynamic var desc: String = ""
    @objc dynamic var favorite = false
    
    var developers = List<DeveloperEntity>()
    var publishers = List<PublisherEntity>()
    
    public override class func primaryKey() -> String? {
        return "id"
    }
    
}

public class DeveloperEntity: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    
}

public class PublisherEntity: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    
}
