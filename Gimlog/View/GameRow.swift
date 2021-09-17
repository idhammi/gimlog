//
//  GameRow.swift
//  Gimlog
//
//  Created by Idham on 16/09/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameRow: View {
    var game: Game
    
    var body: some View {
        HStack {
            WebImage(url: URL(string: game.backgroundImage))
                .resizable()
                .transition(.fade(duration: 0.5))
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 0) {
                Text(game.name)
                    .font(.system(size: 20))
                
                Text(game.released)
                    .font(.system(size: 14))
                    .lineLimit(3)
            }.padding(.leading, 8)
            
        }.padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
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
        GameRow(game: game).previewLayout(.fixed(width: 400, height: 100))
    }
}
