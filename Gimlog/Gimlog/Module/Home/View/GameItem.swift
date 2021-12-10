//
//  GameItem.swift
//  Gimlog
//
//  Created by Idham on 16/09/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Game

struct GameItem: View {
    var game: GameModel
    
    var body: some View {
        VStack(alignment: .leading) {
            WebImage(url: URL(string: game.backgroundImage))
                .resizable()
                .transition(.fade(duration: 0.5))
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .aspectRatio(0.85, contentMode: .fill)
            
            VStack(alignment: .leading) {
                Text(game.name)
                    .foregroundColor(Color("BlackSoft"))
                    .font(.system(size: 14))
                    .lineLimit(1)
                
                Text("\(game.getYearReleased())  |  \(String(game.rating)) ★")
                    .foregroundColor(.orange)
                    .font(.system(size: 12))
                    .lineLimit(1)
            }
            .padding(EdgeInsets(top: 6, leading: 8, bottom: 12, trailing: 8))
            
        }
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1.5)
        )
        .padding([.top, .horizontal])
    }
}
