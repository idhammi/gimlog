//
//  UpdateFavoriteGameRepositoryTests.swift
//  
//
//  Created by Idham on 11/12/21.
//

import XCTest
import Nimble
import Combine
import Swinject
@testable import Game

final class UpdateFavoriteGameRepositoryTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable> = []
    
    @InjectMock private var repository: UpdateFavoriteGameRepository<
        MockGetFavoriteGamesLocaleDataSource, GameTransformer>?
    
    override func setUp() {
        cancellables = []
        precondition(repository != nil)
    }
    
    func testExecute() {
        repository?.execute(request: GameResponse.mockGame.id)
            .sink(receiveCompletion: { _ in },receiveValue: { expect($0.id) == GameResponse.mockGame.id })
            .store(in: &cancellables)
    }
    
#if arch(x86_64) && canImport(Darwin)
    func testExecuteWithoutIdError() {
        expect {
            self.repository?.execute(request: nil)
                .sink(receiveCompletion: { _ in },receiveValue: {expect($0.id) == GameResponse.mockGame.id})
                .store(in: &self.cancellables)
        }.toEventually(throwAssertion())
    }
#endif
    
}
