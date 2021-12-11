//
//  GetGamesRepository.swift
//  
//
//  Created by Idham on 08/12/21.
//

import GimlogCore
import Combine

public struct GetGamesRepository<
    GameLocalDataSource: LocaleDataSource,
    RemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
GameLocalDataSource.Request == Int,
GameLocalDataSource.Response == GameEntity,
RemoteDataSource.Request == [String: String],
RemoteDataSource.Response == [GameResponse],
Transformer.Response == [GameResponse],
Transformer.Entity == [GameEntity],
Transformer.Domain == [GameModel] {
    
    public typealias Request = [String: String]
    public typealias Response = [GameModel]
    
    private let _localeDataSource: GameLocalDataSource
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer
    
    public init(
        localeDataSource: GameLocalDataSource,
        remoteDataSource: RemoteDataSource,
        mapper: Transformer) {
            _localeDataSource = localeDataSource
            _remoteDataSource = remoteDataSource
            _mapper = mapper
        }
    
    public func execute(request: [String: String]?) -> AnyPublisher<[GameModel], Error> {
        return _localeDataSource.list(request: nil)
            .flatMap { result -> AnyPublisher<[GameModel], Error> in
                if result.isEmpty {
                    return _remoteDataSource.execute(request: request)
                        .map { _mapper.transformResponseToEntity(response: $0) }
                        .catch { _ in _localeDataSource.list(request: nil) }
                        .flatMap {  _localeDataSource.add(entities: $0) }
                        .filter { $0 }
                        .flatMap { _ in _localeDataSource.list(request: nil)
                        .map {  _mapper.transformEntityToDomain(entity: $0) }
                        }.eraseToAnyPublisher()
                } else {
                    return _localeDataSource.list(request: nil)
                        .map { _mapper.transformEntityToDomain(entity: $0) }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
}

