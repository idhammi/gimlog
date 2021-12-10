//
//  GameTransformer.swift
//  
//
//  Created by Idham on 08/12/21.
//

import Core

public struct GamesTransformer<GameMapper: Mapper>: Mapper
where
GameMapper.Request == Int,
GameMapper.Response == GameResponse,
GameMapper.Entity == GameEntity,
GameMapper.Domain == GameModel {
    
    public typealias Request = Int
    public typealias Response = [GameResponse]
    public typealias Entity = [GameEntity]
    public typealias Domain = [GameModel]
    
    private let _gameMapper: GameMapper
    
    public init(gameMapper: GameMapper) {
        _gameMapper = gameMapper
    }
    
    public func transformResponseToEntity(request: Int?, response: [GameResponse]) -> [GameEntity] {
        return response.map { result in
            _gameMapper.transformResponseToEntity(request: request, response: result)
        }
    }
    
    public func transformEntityToDomain(entity: [GameEntity]) -> [GameModel] {
        return entity.map { result in
            _gameMapper.transformEntityToDomain(entity: result)
        }
    }
    
}
