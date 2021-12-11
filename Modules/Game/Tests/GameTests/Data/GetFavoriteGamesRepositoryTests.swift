//
//  GetFavoriteGamesRepositoryTests.swift
//  
//
//  Created by Idham on 11/12/21.
//

import XCTest
import Nimble
import Combine
import Swinject
@testable import Game

final class GetFavoriteGamesRepositoryTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable> = []
    
    @InjectMock private var repository: GetFavoriteGamesRepository<
        MockGetFavoriteGamesLocaleDataSource, GamesTransformer<GameTransformer>>?
    
    override func setUp() {
        cancellables = []
        precondition(repository != nil)
    }
    
    func testExecute() {
        repository?.execute(request: nil)
            .sink(receiveCompletion: { _ in },receiveValue: { expect($0[0].id) == GameResponse.mockGame.id })
            .store(in: &cancellables)
    }
    
}
