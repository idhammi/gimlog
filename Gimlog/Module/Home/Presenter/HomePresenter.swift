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
    
    @Inject private var useCase: HomeUseCase
    
    @Published var games: [GameModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init() {}
    
    func getGames() {
        loadingState = true
        useCase.getGames()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                    self.loadingState = false
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
    
    func linkToFavorite<Content: View>(
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeFavoriteView()) { content() }
    }
    
}
