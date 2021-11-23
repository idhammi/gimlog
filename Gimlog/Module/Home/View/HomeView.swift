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
                                self.presenter.linkBuilder(for: game.id) {
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
                self.presenter.linkBuilder {
                    Image(systemName: "heart.fill").font(.title2)
                }
            }
            
            Button {showModalView = true} label: {
                Image(systemName: "info.circle.fill").font(.title2)
            }
            .sheet(isPresented: $showModalView) {
                AboutView()
            }
        })
    }
    
}
