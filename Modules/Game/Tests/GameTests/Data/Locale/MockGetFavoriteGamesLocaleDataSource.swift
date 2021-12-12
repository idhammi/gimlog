//
//  MockGetFavoriteGamesLocaleDataSource.swift
//  
//
//  Created by Idham on 11/12/21.
//

import GimlogCore
import Combine
import RealmSwift
import Game
import Foundation

public struct MockGetFavoriteGamesLocaleDataSource : LocaleDataSource {
    
    public typealias Request = Int
    public typealias Response = GameEntity
    
    public func list(request: Int?) -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            completion(.success(GamesTransformer(gameMapper: GameTransformer())
                                    .transformResponseToEntity(response: GameResponse.mockGames)))
            
        }.eraseToAnyPublisher()
    }
    
    public func add(entities: [GameEntity]) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public func get(id: Int) -> AnyPublisher<GameEntity, Error> {
        return Future<GameEntity, Error> { completion in
            completion(.success(GameTransformer().transformResponseToEntity(response: GameResponse.mockGame)))
        }.eraseToAnyPublisher()
    }
    
    public func update(id: Int, entity: GameEntity) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
}

