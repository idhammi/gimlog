//
//  HomeView.swift
//  Gimlog
//
//  Created by Idham on 23/11/21.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var presenter: HomePresenter
    
    @State private var showModalView = false
    @State private var searchText = ""
    
    var columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var searchResults: [GameModel] {
        if searchText.isEmpty {
            return self.presenter.games
        } else {
            return self.presenter.games.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        ZStack {
            if #available(iOS 15.0, *) {
                Spacer().searchable(text: $searchText)
            }
            if presenter.loadingState {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
            } else {
                if self.presenter.games.count > 0 {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(searchResults) { game in
                                self.presenter.linkToDetail(for: game.id) {
                                    GameItem(game: game)
                                }
                            }
                        }
                    }
                } else {
                    Text("Data not found").foregroundColor(Color("BlackSoft"))
                }
            }
        }
        .navigationBarTitle(Text("Gimlog"))
        .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.large)
        .onAppear {
            if self.presenter.games.count == 0 {
                self.presenter.getGames()
            }
        }
        .navigationBarItems(trailing: HStack {
            Button {} label: {
                self.presenter.linkToFavorite {
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
