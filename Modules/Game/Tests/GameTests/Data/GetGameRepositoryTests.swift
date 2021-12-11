//
//  GetGameRepositoryTests.swift
//  
//
//  Created by Idham on 11/12/21.
//

import XCTest
import Nimble
import Combine
import Swinject
@testable import Game

final class GetGameRepositoryTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable> = []
    
    @InjectMock private var repository: GetGameRepository<
        MockGetGamesLocaleDataSource, MockGetGameRemoteDataSource, GameTransformer>?
    
    override func setUp() {
        cancellables = []
        precondition(repository != nil)
    }
    
    func testExecute() {
        repository?.execute(request: ["id": String(GameResponse.mockGame.id)])
            .sink(receiveCompletion: { _ in }, receiveValue: {expect($0.id) == GameResponse.mockGame.id})
            .store(in: &cancellables)
    }
    
#if arch(x86_64) && canImport(Darwin)
    func testExecuteWithoutIdError() {
        expect {
            self.repository?.execute(request: nil)
                .sink(receiveCompletion: { _ in }, receiveValue: {expect($0.id) == GameResponse.mockGame.id})
                .store(in: &self.cancellables)
        }.toEventually(throwAssertion())
    }
#endif
    
}
