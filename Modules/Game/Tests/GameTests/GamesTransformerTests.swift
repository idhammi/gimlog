//
//  GamesTransformerTests.swift
//  
//
//  Created by Idham on 11/12/21.
//

import XCTest
import Nimble
import Swinject
@testable import Game

final class GamesTransformerTests: XCTestCase {
    
    @InjectMock private var transformer: GamesTransformer<GameTransformer>
    
    func testTransformResponseToEntity() {
        expect(self.transformer.transformResponseToEntity(response: GameResponse.mockGames)).to(beAKindOf([GameEntity].self))
    }
    func testTransformEntityToDomain() {
        let entities = transformer.transformResponseToEntity(response: GameResponse.mockGames)
        expect(self.transformer.transformEntityToDomain(entity: entities)).to(beAKindOf([GameModel].self))
    }
    
}
