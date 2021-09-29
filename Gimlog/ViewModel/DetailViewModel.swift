//
//  DetailFetcher.swift
//  Gimlog
//
//  Created by Idham on 17/09/21.
//

import Foundation

class DetailViewModel: ObservableObject {
    
    @Published var gameDetail: GameModel?
    @Published var loading = false
    @Published var isFavorite = false
    
    private lazy var provider: GameProvider = { return GameProvider() }()
    
    func getGameDetail(gameId: Int) {
        checkGameStatus(gameId: gameId)
        
        self.loading = true
        ApiRepository.shared.getGameDetail(with: .games, gameId: String(gameId)) { (data, error) in
            do {
                let res = try JSONDecoder().decode(GameModel.self, from: data!)
                DispatchQueue.main.async {
                    self.gameDetail = res
                    self.loading = false
                }
            } catch {
                print(error.localizedDescription)
                self.loading = false
            }
        }
    }
    
    func setGameAsFavorite(item: GameModel, completion: @escaping() -> Void) {
        provider.insertGame(item) {
            DispatchQueue.main.async {
                completion()
                self.isFavorite = true
            }
        }
    }
    
    func removeGameFromFavorite(gameId: Int, completion: @escaping() -> Void) {
        provider.deleteGame(gameId) {
            DispatchQueue.main.async {
                completion()
                self.isFavorite = false
            }
        }
    }
    
    func checkGameStatus(gameId: Int) {
        provider.checkGameExist(gameId) { isExist in
            DispatchQueue.main.async {
                self.isFavorite = isExist
            }
        }
    }
    
}
