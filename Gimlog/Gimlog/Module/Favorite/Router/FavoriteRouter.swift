//
//  FavoriteRouter.swift
//  Gimlog
//
//  Created by Idham on 23/11/21.
//

import SwiftUI
import Core
import Game

class FavoriteRouter {
    
    @Inject("game") private var gameUseCase: Interactor<
        [String: String], GameModel, GetGameRepository<
            GetGamesLocaleDataSource, GetGameRemoteDataSource, GameTransformer>>
    
    @Inject("updateFavorite") private var updateFavoriteUseCase: Interactor<
        Int, GameModel, UpdateFavoriteGameRepository<
            GetFavoriteGamesLocaleDataSource, GameTransformer>>
    
    func makeDetailView(for gameId: Int) -> some View {
        let presenter = GamePresenter(gameUseCase: gameUseCase, favoriteUseCase: updateFavoriteUseCase)
        return DetailView(presenter: presenter, gameId: gameId)
    }
    
}
