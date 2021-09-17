//
//  ListFetcher.swift
//  Gimlog
//
//  Created by Idham on 16/09/21.
//

import Foundation
import SwiftUI

class ListFetcher: ObservableObject {
    
    @Published var gamesList = [Game]()
    @Published var loading = false
    
    init() {
        getGamesList()
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
            }
        }
    }
    
}
