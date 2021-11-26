//
//  DetailInteractor.swift
//  Gimlog
//
//  Created by Idham on 23/11/21.
//

import Combine

protocol DetailUseCase {
    
    func getGameDetail(gameId: Int) -> AnyPublisher<GameModel, Error>
    func addGameToFavorites(game: GameEntity) -> AnyPublisher<Bool, Error>
    func deleteGameFromFavorites(gameId: Int) -> AnyPublisher<Bool, Error>
    func checkGameStatus(gameId: Int) -> AnyPublisher<Bool, Error>
    
}

class DetailInteractor: DetailUseCase {
    
    private let repository: GimlogRepositoryProtocol
    
    required init(repository: GimlogRepositoryProtocol) {
        self.repository = repository
    }
    
    func getGameDetail(gameId: Int) -> AnyPublisher<GameModel, Error> {
        return repository.getGameDetail(gameId: gameId)
    }
    
    func addGameToFavorites(game: GameEntity) -> AnyPublisher<Bool, Error> {
        return repository.addGameToFavorites(game: game)
    }
    
    func deleteGameFromFavorites(gameId: Int) -> AnyPublisher<Bool, Error> {
        return repository.deleteGameFromFavorites(gameId: gameId)
    }
    
    func checkGameStatus(gameId: Int) -> AnyPublisher<Bool, Error> {
        return repository.checkGameStatus(gameId: gameId)
    }
    
}
