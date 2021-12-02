//
//  LocaleDataSource.swift
//  Gimlog
//
//  Created by Idham on 19/11/21.
//

import RealmSwift
import Combine
import MapKit

protocol LocaleDataSourceProtocol: AnyObject {
    
    func getGames() -> AnyPublisher<[GameEntity], Error>
    func addGame(from game: GameEntity) -> AnyPublisher<Bool, Error>
    func deleteGame(_ id: Int) -> AnyPublisher<Bool, Error>
    func checkGameExist(_ id: Int) -> AnyPublisher<Bool, Error>
    
}

final class LocaleDataSource: NSObject {
    
    private let realm: Realm?
    
    init(realm: Realm?) {
        self.realm = realm
    }
    
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    
    func getGames() -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            if let realm = self.realm {
                let games: Results<GameEntity> = {
                    realm.objects(GameEntity.self)
                        .sorted(byKeyPath: "name", ascending: true)
                }()
                completion(.success(games.toArray(ofType: GameEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func addGame(from game: GameEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(game, update: .all)
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func deleteGame(_ id: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    let object = realm.objects(GameEntity.self).filter("id = %@", id).first
                    try realm.write {
                        if let obj = object {
                            realm.delete(obj)
                            completion(.success(true))
                        }
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func checkGameExist(_ id: Int) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    let object = realm.objects(GameEntity.self).filter("id = %@", id).first
                    if object != nil {
                        completion(.success(true))
                    } else {
                        completion(.success(false))
                    }
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
}

extension Results {
    
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
    
}
