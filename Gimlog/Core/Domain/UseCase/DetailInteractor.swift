//
//  DetailInteractor.swift
//  Gimlog
//
//  Created by Idham on 23/11/21.
//

import Foundation
import Combine

protocol DetailUseCase {
    
    func getGameDetail() -> AnyPublisher<GameModel, Error>
    func addGameToFavorites(game: GameEntity) -> AnyPublisher<Bool, Error>
    func deleteGameFromFavorites() -> AnyPublisher<Bool, Error>
    func checkGameStatus() -> AnyPublisher<Bool, Error>
    
}

class DetailInteractor: DetailUseCase {
    
    private let repository: GimlogRepositoryProtocol
    private let gameId: Int
    
    required init(
        repository: GimlogRepositoryProtocol,
        gameId: Int
    ) {
        self.repository = repository
        self.gameId = gameId
    }
    
    func getGameDetail() -> AnyPublisher<GameModel, Error> {
        return repository.getGameDetail(gameId: gameId)
    }
    
    func addGameToFavorites(game: GameEntity) -> AnyPublisher<Bool, Error> {
        return repository.addGameToFavorites(game: game)
    }
    
    func deleteGameFromFavorites() -> AnyPublisher<Bool, Error> {
        return repository.deleteGameFromFavorites(gameId: gameId)
    }
    
    func checkGameStatus() -> AnyPublisher<Bool, Error> {
        return repository.checkGameStatus(gameId: gameId)
    }
    
}
