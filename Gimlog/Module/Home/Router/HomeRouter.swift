//
//  HomeRouter.swift
//  Gimlog
//
//  Created by Idham on 23/11/21.
//

import SwiftUI

class HomeRouter {
    
    func makeDetailView(for gameId: Int) -> some View {
        let detailUseCase = Injection.init().provideDetail(gameId: gameId)
        let presenter = DetailPresenter(detailUseCase: detailUseCase)
        return DetailView(presenter: presenter)
    }
    
    func makeFavoriteView() -> some View {
        let favoriteUseCase = Injection.init().provideFavorite()
        let presenter = FavoritePresenter(favoriteUseCase: favoriteUseCase)
        return FavoriteView(presenter: presenter)
    }
    
}
