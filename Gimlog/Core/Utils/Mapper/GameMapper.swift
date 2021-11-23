//
//  GameMapper.swift
//  Gimlog
//
//  Created by Idham on 22/11/21.
//

import RealmSwift

final class GameMapper {
    
    static func mapGameEntitiesToDomains(
        input gameEntities: [GameEntity]
    ) -> [GameModel] {
        return gameEntities.map { result in
            return GameModel(
                id: result.id,
                name: result.name,
                released: result.released,
                backgroundImage: result.backgroundImage,
                rating: result.rating
            )
        }
    }
    
    static func mapGameResponsesToDomains(
        input gameResponses: [GameResponse]
    ) -> [GameModel] {
        return gameResponses.map { result in
            return GameModel(
                id: result.id ?? 0,
                name: result.name ?? "Unknown",
                released: result.released ?? "Unknown",
                backgroundImage: result.backgroundImage ?? "Unknown",
                rating: result.rating ?? 0.0,
                description: result.description ?? "Unknown"
            )
        }
    }
    
    static func mapGameResponseToDomain(
        input gameResponse: GameResponse
    ) -> GameModel {
        return GameModel(
            id: gameResponse.id ?? 0,
            name: gameResponse.name ?? "Unknown",
            released: gameResponse.released ?? "Unknown",
            backgroundImage: gameResponse.backgroundImage ?? "Unknown",
            rating: gameResponse.rating ?? 0.0,
            description: gameResponse.description ?? "Unknown",
            developers: mapDevResponsesToDevDomains(input: gameResponse.developers ?? []),
            publishers: mapPubResponsesToPubDomains(input: gameResponse.publishers ?? [])
        )
    }
    
    static func mapGameDomainToEntity(
        input gameModel: GameModel
    ) -> GameEntity {
        let entity = GameEntity()
        entity.id = gameModel.id
        entity.name = gameModel.name ?? ""
        entity.released = gameModel.released ?? ""
        entity.backgroundImage = gameModel.backgroundImage ?? ""
        entity.rating = gameModel.rating ?? 0.0
        return entity
    }
    
    static func mapDevResponsesToDevDomains(
        input devResponses: [DeveloperResponse]
    ) -> [DeveloperModel] {
        return devResponses.map { result in
            return DeveloperModel(
                id: result.id ?? 0,
                name: result.name ?? ""
            )
        }
    }
    
    static func mapPubResponsesToPubDomains(
        input pubResponses: [PublisherResponse]
    ) -> [PublisherModel] {
        return pubResponses.map { result in
            return PublisherModel(
                id: result.id ?? 0,
                name: result.name ?? ""
            )
        }
    }
    
}
