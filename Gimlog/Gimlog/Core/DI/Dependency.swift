//
//  Dependency.swift
//  Gimlog
//
//  Created by Idham on 10/12/21.
//

import Swinject
import RealmSwift
import Core
import Game

class AppAssembly: Assembly {
    func assemble(container: Container) {
        container.register(Realm.self) { _ in
            guard let realm = try? Realm() else { fatalError( "Cannot initialize realm instance" ) }
            return realm
        }
    }
}

class DataSourceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(GetFavoriteGamesLocaleDataSource.self) { r in
            GetFavoriteGamesLocaleDataSource(realm: r.resolve(Realm.self)!)
        }
        container.register(GetGamesLocaleDataSource.self) { r in
            GetGamesLocaleDataSource(realm: r.resolve(Realm.self)!)
        }
        container.register(GetGamesRemoteDataSource.self) { _ in
            GetGamesRemoteDataSource(endpoint: Endpoints.getGames())
        }
        container.register(GetGameRemoteDataSource.self) { _ in
            GetGameRemoteDataSource(endpoint: Endpoints.getGameDetail())
        }
    }
}

class TransformerAssembly: Assembly {
    func assemble(container: Container) {
        container.register(GameTransformer.self) { _ in GameTransformer()}
        container.register(GamesTransformer<GameTransformer>.self) { r in
            GamesTransformer(gameMapper: r.resolve(GameTransformer.self)!)
        }
    }
}

class RepositoryAssembly: Assembly {
    func assemble(container: Container) {
        container.register(GetFavoriteGamesRepository.self) { r in
            GetFavoriteGamesRepository(
                localeDataSource: r.resolve(GetFavoriteGamesLocaleDataSource.self)!,
                mapper: r.resolve(GamesTransformer<GameTransformer>.self)!
            )
        }
        container.register(GetGameRepository.self) { r in
            GetGameRepository(
                localeDataSource: r.resolve(GetGamesLocaleDataSource.self)!,
                remoteDataSource: r.resolve(GetGameRemoteDataSource.self)!,
                mapper: r.resolve(GameTransformer.self)!
            )
        }
        container.register(GetGamesRepository.self) { r in
            GetGamesRepository(
                localeDataSource: r.resolve(GetGamesLocaleDataSource.self)!,
                remoteDataSource: r.resolve(GetGamesRemoteDataSource.self)!,
                mapper: r.resolve(GamesTransformer<GameTransformer>.self)!
            )
        }
        container.register(UpdateFavoriteGameRepository.self) { r in
            UpdateFavoriteGameRepository(
                localeDataSource: r.resolve(GetFavoriteGamesLocaleDataSource.self)!,
                mapper: r.resolve(GameTransformer.self)!
            )
        }
    }
}

class UseCaseAssembly: Assembly {
    func assemble(container: Container) {
        container.register(
            Interactor<Int, [GameModel], GetFavoriteGamesRepository<GetFavoriteGamesLocaleDataSource,
            GamesTransformer<GameTransformer>>>.self, name: "favorite") { r in
                Interactor(repository: r.resolve(GetFavoriteGamesRepository.self)!)
            }
        container.register(
            Interactor<[String: String], [GameModel], GetGamesRepository<GetGamesLocaleDataSource,
            GetGamesRemoteDataSource, GamesTransformer<GameTransformer>>>.self, name: "games") { r in
                Interactor(repository: r.resolve(GetGamesRepository.self)!)
            }
        container.register(
            Interactor<[String: String], GameModel, GetGameRepository<GetGamesLocaleDataSource,
            GetGameRemoteDataSource, GameTransformer>>.self, name: "game") { r in
                Interactor(repository: r.resolve(GetGameRepository.self)!)
            }
        container.register(
            Interactor<Int, GameModel, UpdateFavoriteGameRepository<GetFavoriteGamesLocaleDataSource,
            GameTransformer>>.self, name: "updateFavorite") { r in
                Interactor(repository: r.resolve(UpdateFavoriteGameRepository.self)!)
            }
    }
}
