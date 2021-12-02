//
//  FavoriteView.swift
//  Gimlog
//
//  Created by Idham on 23/11/21.
//

import SwiftUI

struct FavoriteView: View {
    
    @ObservedObject var presenter: FavoritePresenter
    
    @State private var showModalView = false
    
    var columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        ZStack {
            if presenter.loadingState {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
            } else {
                if self.presenter.games.count > 0 {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(self.presenter.games) { game in
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
        .navigationBarTitle(Text("Favorites"))
        .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
        .onAppear {
            self.presenter.getGamesFavorite()
        }
    }
    
}
