//
//  DetailPresenter.swift
//  Gimlog
//
//  Created by Idham on 23/11/21.
//

import SwiftUI
import Combine

class DetailPresenter: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private let gameId: Int
    
    @Inject private var useCase: DetailUseCase
    
    @Published var game: GameModel?
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    @Published var isFavorite: Bool = false
    
    init(gameId: Int) {
        self.gameId = gameId
    }
    
    func getGameDetail() {
        checkGameStatus()
        loadingState = true
        useCase.getGameDetail(gameId: gameId)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { game in
                self.game = game
            })
            .store(in: &cancellables)
    }
    
    func addGameToFavorites(_ game: GameModel, complete: @escaping() -> Void) {
        useCase.addGameToFavorites(game: game)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    complete()
                }
            }, receiveValue: { _ in
                self.isFavorite = true
            })
            .store(in: &cancellables)
    }
    
    func deleteGameFromFavorites(complete: @escaping() -> Void) {
        useCase.deleteGameFromFavorites(gameId: gameId)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    complete()
                }
            }, receiveValue: { _ in
                self.isFavorite = false
            })
            .store(in: &cancellables)
    }
    
    func checkGameStatus() {
        useCase.checkGameStatus(gameId: gameId)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    break
                }
            }, receiveValue: { isFavorite in
                print("isFavorite \(isFavorite)")
                self.isFavorite = isFavorite
            })
            .store(in: &cancellables)
    }
    
}
