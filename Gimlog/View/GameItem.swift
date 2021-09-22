//
//  GameItem.swift
//  Gimlog
//
//  Created by Idham on 16/09/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameItem: View {
    var game: Game
    
    var body: some View {
        VStack {
            WebImage(url: URL(string: game.backgroundImage))
                .resizable()
                .transition(.fade(duration: 0.5))
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .aspectRatio(0.85, contentMode: .fill)
            
            VStack(alignment: .center) {
                Text(game.name)
                    .foregroundColor(.black)
                    .font(.system(size: 15))
                    .lineLimit(1)
                
                Text(game.getYearReleased())
                    .foregroundColor(.orange)
                    .font(.system(size: 14))
                    .lineLimit(1)
            }
            .padding(EdgeInsets(top: 8, leading: 8, bottom: 12, trailing: 8))
            
        }
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1.5)
        )
        .padding([.top, .horizontal])
    }
}

struct GameRow_Previews: PreviewProvider {
    static var game = Game(
        id: 1,
        name: "Red Dead Redemption 2",
        released: "2018-10-26",
        backgroundImage: "https://media.rawg.io/media/games/511/5118aff5091cb3efec399c808f8c598f.jpg"
    )
    
    static var previews: some View {
        GameItem(game: game).previewLayout(.fixed(width: 350, height: 500))
    }
}
