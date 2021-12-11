//
//  GameTransformer.swift
//  
//
//  Created by Idham on 09/12/21.
//

import Core
import RealmSwift

public struct GameTransformer: Mapper {
    
    public typealias Response = GameResponse
    public typealias Entity = GameEntity
    public typealias Domain = GameModel
    
    public init() { }
    
    public func transformResponseToEntity(response: GameResponse) -> GameEntity {
        let entity = GameEntity()
        entity.id = response.id
        entity.name = response.name ?? "-"
        entity.released = response.released ?? "-"
        entity.backgroundImage = response.backgroundImage ?? "-"
        entity.rating = response.rating ?? 0.0
        entity.desc = response.description ?? "-"
        entity.developers = devResponsesToEntities(input: response.developers ?? [])
        entity.publishers = pubResponsesToEntities(input: response.publishers ?? [])
        return entity
    }
    
    public func transformEntityToDomain(entity: GameEntity) -> GameModel {
        return GameModel(
            id: entity.id,
            name: entity.name,
            released: entity.released,
            backgroundImage: entity.backgroundImage,
            rating: entity.rating,
            description: entity.desc,
            developers: devEntitiesToDomains(entities: entity.developers),
            publishers: pubEntitiesToDomains(entities: entity.publishers),
            favorite: entity.favorite
        )
    }
    
    func devResponsesToEntities(input response: [DeveloperResponse]) -> List<DeveloperEntity> {
        let entities = List<DeveloperEntity>()
        for developer in response {
            let entity = DeveloperEntity()
            entity.id = developer.id ?? 0
            entity.name = developer.name ?? "-"
            entities.append(entity)
        }
        return entities
    }
    
    func pubResponsesToEntities(input response: [PublisherResponse]) -> List<PublisherEntity> {
        let entities = List<PublisherEntity>()
        for developer in response {
            let entity = PublisherEntity()
            entity.id = developer.id ?? 0
            entity.name = developer.name ?? "-"
            entities.append(entity)
        }
        return entities
    }
    
    func devEntitiesToDomains(entities: List<DeveloperEntity>) -> [DeveloperModel] {
        return entities.map { result in
            return DeveloperModel(
                id: result.id,
                name: result.name
            )
        }
    }
    
    func pubEntitiesToDomains(entities: List<PublisherEntity>) -> [PublisherModel] {
        return entities.map { result in
            return PublisherModel(
                id: result.id,
                name: result.name
            )
        }
    }
}
