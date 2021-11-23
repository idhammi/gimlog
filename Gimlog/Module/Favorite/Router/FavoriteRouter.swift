//
//  FavoriteRouter.swift
//  Gimlog
//
//  Created by Idham on 23/11/21.
//

import SwiftUI

class FavoriteRouter {
    
    func makeDetailView(for gameId: Int) -> some View {
        let detailUseCase = Injection.init().provideDetail(gameId: gameId)
        let presenter = DetailPresenter(detailUseCase: detailUseCase)
        return DetailView(presenter: presenter)
    }
    
}
