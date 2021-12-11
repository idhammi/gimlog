//
//  GamePresenterTests.swift
//  
//
//  Created by Idham on 11/12/21.
//

import XCTest
import Nimble
import Combine
import Core
import Swinject
@testable import Game

final class GamePresenterTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable> = []
    
    @InjectMock("game") private var gameUseCase: Interactor<
        [String: String], GameModel, GetGameRepository<
            MockGetGamesLocaleDataSource, MockGetGameRemoteDataSource, GameTransformer>>
    
    @InjectMock("updateFavorite") private var updateFavoriteUseCase: Interactor<
        Int, GameModel, UpdateFavoriteGameRepository<
            MockGetFavoriteGamesLocaleDataSource, GameTransformer>>
    
    private var presenter: GamePresenter<
        Interactor<[String: String], GameModel, GetGameRepository<
            MockGetGamesLocaleDataSource, MockGetGameRemoteDataSource, GameTransformer>>,
        Interactor<Int, GameModel, UpdateFavoriteGameRepository<
            MockGetFavoriteGamesLocaleDataSource, GameTransformer>>
    >?
    
    override func setUp() {
        cancellables = []
        presenter = GamePresenter(gameUseCase: gameUseCase, favoriteUseCase: updateFavoriteUseCase)
        precondition(presenter != nil)
    }
    
    func testGetGame() {
        presenter?.getGame(request: ["id": String(GameResponse.mockGame.id)])
        expect(self.presenter?.item?.id).toEventually(equal(GameResponse.mockGame.id))
        expect(self.presenter?.errorMessage).toEventually(equal(""))
        expect(self.presenter?.isError).toEventually(equal(false))
    }
    
    func testUpdateFavoriteGame() {
        presenter?.updateFavoriteGame(request: GameResponse.mockGame.id) {}
        expect(self.presenter?.item?.id).toEventually(equal(GameResponse.mockGame.id))
        expect(self.presenter?.errorMessage).toEventually(equal(""))
        expect(self.presenter?.isError).toEventually(equal(false))
    }
    
}
