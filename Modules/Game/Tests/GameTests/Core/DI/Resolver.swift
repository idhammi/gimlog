//
//  Resolver.swift
//  
//
//  Created by Idham on 11/12/21.
//

import Swinject
import GimlogCore
@testable import Game

class Resolver {
    static let shared = Resolver()
    private let container = buildMockContainer()
    
    func resolve<T>(_ type: T.Type, name: String?) -> T {
        container.resolve(T.self, name: name)!
    }
}

func buildMockContainer() -> Container {
    let container = Container()
    
    container.register(GameTransformer.self) { _ in GameTransformer()}
    container.register(GamesTransformer<GameTransformer>.self) { r in
        GamesTransformer(gameMapper: r.resolve(GameTransformer.self)!)
    }
    
    container.register(MockGetFavoriteGamesLocaleDataSource.self) { _ in
        MockGetFavoriteGamesLocaleDataSource()
    }
    container.register(MockGetGamesLocaleDataSource.self) { _ in
        MockGetGamesLocaleDataSource()
    }
    container.register(MockGetGamesRemoteDataSource.self) { _ in
        MockGetGamesRemoteDataSource(endpoint: "endpoint")
    }
    container.register(MockGetGameRemoteDataSource.self) { _ in
        MockGetGameRemoteDataSource(endpoint: "endpoint")
    }
    
    container.register(GetFavoriteGamesRepository<MockGetFavoriteGamesLocaleDataSource,
                       GamesTransformer<GameTransformer>>.self) { r in
        GetFavoriteGamesRepository(
            localeDataSource: r.resolve(MockGetFavoriteGamesLocaleDataSource.self)!,
            mapper: r.resolve(GamesTransformer<GameTransformer>.self)!
        )
    }
    container.register(GetGameRepository<MockGetGamesLocaleDataSource, MockGetGameRemoteDataSource,
                       GameTransformer>.self) { r in
        GetGameRepository(
            localeDataSource: r.resolve(MockGetGamesLocaleDataSource.self)!,
            remoteDataSource: r.resolve(MockGetGameRemoteDataSource.self)!,
            mapper: r.resolve(GameTransformer.self)!
        )
    }
    container.register(GetGamesRepository<MockGetGamesLocaleDataSource, MockGetGamesRemoteDataSource,
                       GamesTransformer<GameTransformer>>.self) { r in
        GetGamesRepository(
            localeDataSource: r.resolve(MockGetGamesLocaleDataSource.self)!,
            remoteDataSource: r.resolve(MockGetGamesRemoteDataSource.self)!,
            mapper: r.resolve(GamesTransformer<GameTransformer>.self)!
        )
    }
    container.register(UpdateFavoriteGameRepository<MockGetFavoriteGamesLocaleDataSource,
                       GameTransformer>.self) { r in
        UpdateFavoriteGameRepository(
            localeDataSource: r.resolve(MockGetFavoriteGamesLocaleDataSource.self)!,
            mapper: r.resolve(GameTransformer.self)!
        )
    }
    
    container.register(
        Interactor<[String: String], GameModel, GetGameRepository<MockGetGamesLocaleDataSource,
        MockGetGameRemoteDataSource, GameTransformer>>.self, name: "game") { r in
            Interactor(repository: r.resolve(GetGameRepository.self)!)
        }
    container.register(
        Interactor<Int, GameModel, UpdateFavoriteGameRepository<MockGetFavoriteGamesLocaleDataSource,
        GameTransformer>>.self, name: "updateFavorite") { r in
            Interactor(repository: r.resolve(UpdateFavoriteGameRepository.self)!)
        }
    
    return container
}
