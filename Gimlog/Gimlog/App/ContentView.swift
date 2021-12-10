//
//  ContentView.swift
//  Gimlog
//
//  Created by Idham on 16/09/21.
//

import SwiftUI
import Core
import Game

struct ContentView: View {
    
    @EnvironmentObject var homePresenter: GetListPresenter<[String: String], GameModel, Interactor<
        [String: String], [GameModel], GetGamesRepository<
            GetGamesLocaleDataSource, GetGamesRemoteDataSource, GamesTransformer<GameTransformer>>>>
    
    var body: some View {
        NavigationView {
            HomeView(presenter: homePresenter)
        }
        .navigationAppearance(
            backgroundColor: .orange, foregroundColor: .systemBackground,
            tintColor: .systemBackground, hideSeparator: true
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
