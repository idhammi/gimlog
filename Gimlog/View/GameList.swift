//
//  GameList.swift
//  Gimlog
//
//  Created by Idham on 16/09/21.
//

import SwiftUI

struct GameList: View {
    
    var isFavorite: Bool = false
    
    var titleMode: NavigationBarItem.TitleDisplayMode {
        if isFavorite {
            return NavigationBarItem.TitleDisplayMode.inline
        } else {
            return NavigationBarItem.TitleDisplayMode.large
        }
    }
    
    var title: String {
        if isFavorite {
            return "Favorites"
        } else {
            return "Gimlog"
        }
    }
    
    @ObservedObject var vm = ListViewModel()
    
    var columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        ZStack {
            if vm.gamesList.count > 0 {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(vm.gamesList) { game in
                            NavigationLink(destination: GameDetail(gameId: game.id ?? -1)) {
                                GameItem(game: game)
                            }
                        }
                    }
                }
            } else {
                if !vm.loading {
                    Text("Data not found")
                        .foregroundColor(Color("BlackSoft"))
                }
            }
            
            if vm.loading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
            }
        }
        .navigationBarTitle(Text(title))
        .navigationBarTitleDisplayMode(titleMode)
        .onAppear {
            if !isFavorite {
                if vm.gamesList.count == 0 {
                    vm.getData(isFavorite: isFavorite)
                }
            } else {
                vm.getData(isFavorite: isFavorite)
            }
        }
    }
}
