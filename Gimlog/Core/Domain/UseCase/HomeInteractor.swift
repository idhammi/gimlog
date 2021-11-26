//
//  HomeInteractor.swift
//  Gimlog
//
//  Created by Idham on 23/11/21.
//

import Combine

protocol HomeUseCase {
    
    func getGames() -> AnyPublisher<[GameModel], Error>
    
}

class HomeInteractor: HomeUseCase {
    
    private let repository: GimlogRepositoryProtocol
    
    required init(repository: GimlogRepositoryProtocol) {
        self.repository = repository
    }
    
    func getGames() -> AnyPublisher<[GameModel], Error> {
        return repository.getGames()
    }
    
}
