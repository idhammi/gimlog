//
//  ListFetcher.swift
//  Gimlog
//
//  Created by Idham on 16/09/21.
//

import Foundation

class ListViewModel: ObservableObject {
    
    @Published var gamesList = [GameModel]()
    @Published var loading = false
    
    private lazy var provider: GameProvider = { return GameProvider() }()
    
    func getData(isFavorite: Bool) {
        if isFavorite {
            getGamesListFavorite()
        } else {
            getGamesList()
        }
    }
    
    func getGamesList() {
        self.loading = true
        ApiRepository.shared.getGamesList(with: .games) { (data, error) in
            do {
                let res = try JSONDecoder().decode(GameListResponse.self, from: data!)
                DispatchQueue.main.async {
                    self.gamesList = res.results
                    self.loading = false
                }
            } catch {
                print(error.localizedDescription)
                self.loading = false
            }
        }
    }
    
    func getGamesListFavorite() {
        self.loading = true
        self.provider.getAllGame { result in
            DispatchQueue.main.async {
                self.gamesList = result
                self.loading = false
            }
        }
    }
    
}
