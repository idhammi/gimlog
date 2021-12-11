//
//  GetGamesRepositoryTests.swift
//  
//
//  Created by Idham on 11/12/21.
//

import XCTest
import Nimble
import Combine
import Swinject
@testable import Game

final class GetGamesRepositoryTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable> = []
    
    @InjectMock private var repository: GetGamesRepository<
        MockGetGamesLocaleDataSource, MockGetGamesRemoteDataSource, GamesTransformer<GameTransformer>>?
    
    override func setUp() {
        cancellables = []
        precondition(repository != nil)
    }
    
    func testExecute() {
        repository?.execute(request: nil)
            .sink(receiveCompletion: { _ in }, receiveValue: {expect($0[0].id) == GameResponse.mockGame.id})
            .store(in: &cancellables)
    }
    
    func testExecuteWithRequest() {
        repository?.execute(request: ["test": "test"])
            .sink(receiveCompletion: { _ in }, receiveValue: {expect($0[0].id) == GameResponse.mockGame.id})
            .store(in: &cancellables)
    }
    
}
