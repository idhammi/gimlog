//
//  GameList.swift
//  Gimlog
//
//  Created by Idham on 16/09/21.
//

import SwiftUI

struct GameList: View {
    
    @ObservedObject var fetcher = ListFetcher()
    var columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        ZStack {
            if fetcher.gamesList.count > 0 {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(fetcher.gamesList) { game in
                            NavigationLink(destination: GameDetail(gameId: game.id)) {
                                GameItem(game: game)
                            }
                        }
                    }
                }
            } else {
                if !fetcher.loading {
                    Text("Data not found")
                        .foregroundColor(Color("BlackSoft"))
                }
            }
            
            if fetcher.loading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
            }
        }
    }
}
