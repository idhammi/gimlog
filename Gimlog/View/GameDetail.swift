//
//  GameDetail.swift
//  Gimlog
//
//  Created by Idham on 16/09/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameDetail: View {
    
    var gameId: Int
    @ObservedObject var fetcher = DetailFetcher()
    
    var body: some View {
        ZStack {
            Color(.orange)
                .ignoresSafeArea()
            
            if fetcher.loading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
            }
            
            if let game = fetcher.gameDetail {
                ScrollView {
                    VStack {
                        WebImage(url: URL(string: game.backgroundImage))
                            .resizable()
                            .transition(.fade(duration: 0.5))
                            .aspectRatio(contentMode: .fit)
                        
                        Spacer(minLength: 20)
                        
                        Text(game.name)
                            .font(.system(size: 25))
                            .bold()
                        
                        Spacer(minLength: 4)
                        
                        Text("Released on: " + game.getReleasedFormatted())
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                            .bold()
                        
                        Spacer(minLength: 20)
                        
                        Text(game.description ?? "")
                            .font(.system(size: 16))
                            .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                    }
                }
            } else {
                if !fetcher.loading {
                    Text("Data not found")
                }
            }
        }.onAppear {
            fetcher.getGameDetail(gameId: gameId)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct GameDetail_Previews: PreviewProvider {
    static var previews: some View {
        GameDetail(gameId: 3498)
    }
}
