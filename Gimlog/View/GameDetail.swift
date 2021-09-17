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
            if fetcher.loading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
            }
            ScrollView {
                if let game = fetcher.gameDetail {
                    VStack {
                        Spacer(minLength: 20)
                        
                        Text(game.name)
                            .font(.system(size: 25))
                            .bold()
                        
                        Spacer(minLength: 80)
                        
                        WebImage(url: URL(string: game.backgroundImage))
                            .resizable()
                            .transition(.fade(duration: 0.5))
                            .scaledToFit()
                            .frame(width: 400, height: 340, alignment: .center)
                        
                        Spacer(minLength: 20)
                        
                        Text(game.description ?? "")
                            .font(.system(size: 16))
                    }
                }
            }.padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
        }.onAppear {
            fetcher.getGameDetail(id: gameId)
        }
    }
}

struct GameDetail_Previews: PreviewProvider {    
    static var previews: some View {
        GameDetail(gameId: 3498)
    }
}
