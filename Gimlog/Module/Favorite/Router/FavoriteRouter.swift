//
//  FavoriteRouter.swift
//  Gimlog
//
//  Created by Idham on 23/11/21.
//

import SwiftUI

class FavoriteRouter {
    
    func makeDetailView(for gameId: Int) -> some View {
        let presenter = DetailPresenter(gameId: gameId)
        return DetailView(presenter: presenter)
    }
    
}
