//
//  UpdateFavoriteGameRepository.swift
//  
//
//  Created by Idham on 10/12/21.
//

import Core
import Combine

public struct UpdateFavoriteGameRepository<
    GameLocaleDataSource: LocaleDataSource,
    Transformer: Mapper>: Repository
where
GameLocaleDataSource.Request == Int,
GameLocaleDataSource.Response == GameEntity,
Transformer.Request == Int,
Transformer.Response == GameResponse,
Transformer.Entity == GameEntity,
Transformer.Domain == GameModel {
    
    public typealias Request = Int
    public typealias Response = GameModel
    
    private let _localeDataSource: GameLocaleDataSource
    private let _mapper: Transformer
    
    public init(localeDataSource: GameLocaleDataSource,mapper: Transformer) {
        _localeDataSource = localeDataSource
        _mapper = mapper
    }
    
    public func execute(request: Int?) -> AnyPublisher<GameModel, Error> {
        return _localeDataSource.get(id: request ?? -1)
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
    }
}
