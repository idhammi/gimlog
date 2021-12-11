//
//  GameTransformerTests.swift
//  
//
//  Created by Idham on 11/12/21.
//

import XCTest
import Nimble
import Swinject
@testable import Game

final class GameTransformerTests: XCTestCase {
    
    @InjectMock private var transformer: GameTransformer
    
    func testTransformResponseToEntity() {
        expect(self.transformer.transformResponseToEntity(response: GameResponse.mockGame)).to(beAKindOf(GameEntity.self))
    }
    func testTransformEntityToDomain() {
        let entity = transformer.transformResponseToEntity(response: GameResponse.mockGame)
        expect(self.transformer.transformEntityToDomain(entity: entity)).to(beAKindOf(GameModel.self))
    }
    
}
