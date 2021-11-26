//
//  GimlogRepository.swift
//  Gimlog
//
//  Created by Idham on 19/11/21.
//

import Foundation
import Combine

protocol GimlogRepositoryProtocol {
    
    func getGames() -> AnyPublisher<[GameModel], Error>
    func getGameDetail(gameId: Int) -> AnyPublisher<GameModel, Error>
    func getGamesFavorite() -> AnyPublisher<[GameModel], Error>
    func addGameToFavorites(game: GameModel) -> AnyPublisher<Bool, Error>
    func deleteGameFromFavorites(gameId: Int) -> AnyPublisher<Bool, Error>
    func checkGameStatus(gameId: Int) -> AnyPublisher<Bool, Error>
}

final class GimlogRepository: NSObject {
    
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    
    init(locale: LocaleDataSource, remote: RemoteDataSource) {
        self.locale = locale
        self.remote = remote
    }
    
}

extension GimlogRepository: GimlogRepositoryProtocol {
    
    func getGames() -> AnyPublisher<[GameModel], Error> {
        return self.remote.getGames()
            .map { GameMapper.mapGameResponsesToDomains(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func getGameDetail(gameId: Int) -> AnyPublisher<GameModel, Error> {
        return self.remote.getGameDetail(gameId: gameId)
            .map { GameMapper.mapGameResponseToDomain(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func getGamesFavorite() -> AnyPublisher<[GameModel], Error> {
        return self.locale.getGames()
            .map { GameMapper.mapGameEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func addGameToFavorites(game: GameModel) -> AnyPublisher<Bool, Error> {
        return self.locale.addGame(from: GameMapper.mapGameDomainToEntity(input: game))
            .eraseToAnyPublisher()
    }
    
    func deleteGameFromFavorites(gameId: Int) -> AnyPublisher<Bool, Error> {
        return self.locale.deleteGame(gameId)
            .eraseToAnyPublisher()
    }
    
    func checkGameStatus(gameId: Int) -> AnyPublisher<Bool, Error> {
        return self.locale.checkGameExist(gameId)
            .eraseToAnyPublisher()
    }
    
}
