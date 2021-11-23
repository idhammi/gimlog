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
    private let detailUseCase: DetailUseCase
    
    @Published var game: GameModel?
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    @Published var isFavorite: Bool = false
    
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
    }
    
    func getGameDetail() {
        checkGameStatus()
        loadingState = true
        detailUseCase.getGameDetail()
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
        detailUseCase.addGameToFavorites(game: GameMapper.mapGameDomainToEntity(input: game))
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
        detailUseCase.deleteGameFromFavorites()
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
        detailUseCase.checkGameStatus()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    break
                }
            }, receiveValue: { isFavorite in
                self.isFavorite = isFavorite
            })
            .store(in: &cancellables)
    }
    
}
