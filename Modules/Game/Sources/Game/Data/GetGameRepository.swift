//
//  GetGameRepository.swift
//  
//
//  Created by Idham on 09/12/21.
//

import Core
import Combine

public struct GetGameRepository<
    GameLocaleDataSource: LocaleDataSource,
    RemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
GameLocaleDataSource.Request == Int,
GameLocaleDataSource.Response == GameEntity,
RemoteDataSource.Request == [String: String],
RemoteDataSource.Response == GameResponse,
Transformer.Response == GameResponse,
Transformer.Entity == GameEntity,
Transformer.Domain == GameModel {
    
    public typealias Request = [String: String]
    public typealias Response = GameModel
    
    private let _localeDataSource: GameLocaleDataSource
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: GameLocaleDataSource,
        remoteDataSource: RemoteDataSource,
        mapper: Transformer) {
            _localeDataSource = localeDataSource
            _remoteDataSource = remoteDataSource
            _mapper = mapper
        }
    
    public func execute(request: [String: String]?) -> AnyPublisher<GameModel, Error> {
        guard let request = request else { fatalError("Request cannot be empty") }
        guard let id = request["id"] else { fatalError("Id cannot be empty") }
        guard let gameId = Int(id) else { fatalError("Id cannot be empty") }
        
        return _localeDataSource.get(id: gameId)
            .flatMap { result -> AnyPublisher<GameModel, Error> in
                if result.desc == "-" {
                    return _remoteDataSource.execute(request: request)
                        .map { _mapper.transformResponseToEntity(response: $0) }
                        .catch { _ in _localeDataSource.get(id: gameId) }
                        .flatMap { _localeDataSource.update(id: gameId, entity: $0) }
                        .filter { $0 }
                        .flatMap { _ in _localeDataSource.get(id: gameId)
                        .map { _mapper.transformEntityToDomain(entity: $0) }
                        }.eraseToAnyPublisher()
                } else {
                    return _localeDataSource.get(id: gameId)
                        .map { _mapper.transformEntityToDomain(entity: $0) }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
}
