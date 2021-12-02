//
//  FavoritePresenter.swift
//  Gimlog
//
//  Created by Idham on 23/11/21.
//

import SwiftUI
import Combine

class FavoritePresenter: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private let router = FavoriteRouter()
    
    @Inject private var useCase: FavoriteUseCase
    
    @Published var games: [GameModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init() {}
    
    func getGamesFavorite() {
        loadingState = true
        useCase.getGamesFavorite()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { games in
                self.games = games
            })
            .store(in: &cancellables)
    }
    
    func linkToDetail<Content: View>(
        for gameId: Int,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeDetailView(for: gameId)) { content() }
    }
    
}
