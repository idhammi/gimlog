//
//  HomePresenter.swift
//  Gimlog
//
//  Created by Idham on 23/11/21.
//

import SwiftUI
import Combine

class HomePresenter: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private let router = HomeRouter()
    private let homeUseCase: HomeUseCase
    
    @Published var games: [GameModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func getGames() {
        loadingState = true
        homeUseCase.getGames()
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
    
    func linkBuilder<Content: View>(
        for gameId: Int,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeDetailView(for: gameId)) { content() }
    }
    
    func linkBuilder<Content: View>(
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeFavoriteView()) { content() }
    }
    
}