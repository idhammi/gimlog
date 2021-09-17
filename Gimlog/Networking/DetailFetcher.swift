//
//  DetailFetcher.swift
//  Gimlog
//
//  Created by Idham on 17/09/21.
//

import Foundation
import SwiftUI

class DetailFetcher: ObservableObject {
    
    @Published var gameDetail: Game?
    @Published var loading = false
    
    func getGameDetail(id: Int) {
        self.loading = true
        ApiRepository.shared.getGameDetail(with: .games, gameId: String(id)) { (data, error) in
            do {
                let res = try JSONDecoder().decode(Game.self, from: data!)
                DispatchQueue.main.async {
                    self.gameDetail = res
                    self.loading = false
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
