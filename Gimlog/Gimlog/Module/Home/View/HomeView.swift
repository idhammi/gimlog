//
//  HomeView.swift
//  Gimlog
//
//  Created by Idham on 23/11/21.
//

import SwiftUI
import Common
import GimlogCore
import Game

struct HomeView: View {
    
    @ObservedObject var presenter: GetListPresenter<[String: String], GameModel, Interactor<
        [String: String], [GameModel], GetGamesRepository<
            GetGamesLocaleDataSource, GetGamesRemoteDataSource, GamesTransformer<GameTransformer>>>>
    
    @State private var showModalView = false
    @State private var searchText = ""
    
    var columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var searchResults: [GameModel] {
        if searchText.isEmpty {
            return self.presenter.list
        } else {
            return self.presenter.list.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        ZStack {
//            if #available(iOS 15.0, *) {
//                Spacer().searchable(text: $searchText, prompt: LocalizedString.search)
//            }
            if presenter.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
            } else {
                if self.presenter.list.count > 0 {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(searchResults) { game in
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
        .navigationBarTitle(Text("Gimlog"))
        .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.large)
        .onAppear {
            if self.presenter.list.count == 0 {
                let request = ["key": API.getApiKey()]
                self.presenter.getList(request: request)
            }
        }
        .navigationBarItems(trailing: HStack {
            Button {} label: {
                linkToFavorite {
                    Image(systemName: "heart.fill").font(.title2).foregroundColor(.white)
                }
            }
            
            Button {showModalView = true} label: {
                Image(systemName: "info.circle.fill").font(.title2).foregroundColor(.white)
            }
            .sheet(isPresented: $showModalView) {
                AboutView()
            }
        })
    }
    
}

extension HomeView {
    
    func linkToDetail<Content: View>(
        for gameId: Int,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: HomeRouter().makeDetailView(for: gameId)) { content() }
    }
    
    func linkToFavorite<Content: View>(
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: HomeRouter().makeFavoriteView()) { content() }
    }
    
}
