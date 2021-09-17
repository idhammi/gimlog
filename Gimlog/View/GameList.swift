//
//  GameList.swift
//  Gimlog
//
//  Created by Idham on 16/09/21.
//

import SwiftUI

struct GameList: View {
    
    @ObservedObject var fetcher = ListFetcher()
    
    var body: some View {
        ZStack {
            List(fetcher.gamesList) { game in
                NavigationLink(destination: GameDetail(gameId: game.id)) {
                    GameRow(game: game)
                }
            }
            
            if fetcher.loading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
            }
        }
        .navigationBarTitle(Text("Gimlog"), displayMode: .inline)
    }
}
