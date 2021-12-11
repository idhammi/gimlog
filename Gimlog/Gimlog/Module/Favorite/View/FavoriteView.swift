//
//  FavoriteView.swift
//  Gimlog
//
//  Created by Idham on 23/11/21.
//

import SwiftUI
import Common
import Core
import Game

struct FavoriteView: View {
    
    @ObservedObject var presenter: GetListPresenter<Int, GameModel, Interactor<
        Int, [GameModel], GetFavoriteGamesRepository<
            GetFavoriteGamesLocaleDataSource, GamesTransformer<GameTransformer>>>>
    
    @State private var showModalView = false
    
    var columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        ZStack {
            if presenter.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
            } else {
                if self.presenter.list.count > 0 {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(self.presenter.list) { game in
                                linkToDetail(for: game.id) {
                                    GameItem(game: game)
                                }
                            }
                        }
                    }
                } else {
                    Text(LocalizedString.dataNotFound).foregroundColor(Color("BlackSoft"))
                }
            }
        }
        .navigationBarTitle(Text(LocalizedString.favorites))
        .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
        .onAppear {
            self.presenter.getList(request: nil)
        }
    }
    
}

extension FavoriteView {
    
    func linkToDetail<Content: View>(
        for gameId: Int,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: FavoriteRouter().makeDetailView(for: gameId)) { content() }
    }
    
}
