//
//  HomeRouter.swift
//  Gimlog
//
//  Created by Idham on 23/11/21.
//

import SwiftUI

class HomeRouter {
    
    func makeDetailView(for gameId: Int) -> some View {
        let presenter = DetailPresenter(gameId: gameId)
        return DetailView(presenter: presenter)
    }
    
    func makeFavoriteView() -> some View {
        let presenter = FavoritePresenter()
        return FavoriteView(presenter: presenter)
    }
    
}
