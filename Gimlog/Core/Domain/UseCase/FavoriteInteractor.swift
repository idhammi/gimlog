//
//  FavoriteInteractor.swift
//  Gimlog
//
//  Created by Idham on 23/11/21.
//

import Foundation
import Combine

protocol FavoriteUseCase {
    
    func getGamesFavorite() -> AnyPublisher<[GameModel], Error>
    
}

class FavoriteInteractor: FavoriteUseCase {
    
    private let repository: GimlogRepositoryProtocol
    
    required init(repository: GimlogRepositoryProtocol) {
        self.repository = repository
    }
    
    func getGamesFavorite() -> AnyPublisher<[GameModel], Error> {
        return repository.getGamesFavorite()
    }
    
}
