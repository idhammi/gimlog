//
//  RemoteDataSource.swift
//  Gimlog
//
//  Created by Idham on 19/11/21.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol: AnyObject {
    
    func getGames() -> AnyPublisher<[GameResponse], Error>
    func getGameDetail(gameId: Int) -> AnyPublisher<GameResponse, Error>
    
}

final class RemoteDataSource: NSObject {
    
    private override init() { }
    
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
    
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    
    func getGames() -> AnyPublisher<[GameResponse], Error> {
        let params: [String: Any] = ["key": API.apiKey]
        return Future<[GameResponse], Error> { completion in
            if let url = URL(string: Endpoints.getGames()) {
                AF.request(url, parameters: params)
                    .validate()
                    .responseDecodable(of: GamesResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.results))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    func getGameDetail(gameId: Int) -> AnyPublisher<GameResponse, Error> {
        let params: [String: Any] = ["key": API.apiKey]
        return Future<GameResponse, Error> { completion in
            if let url = URL(string: Endpoints.getGameDetail(gameId: gameId)) {
                AF.request(url, parameters: params)
                    .validate()
                    .responseDecodable(of: GameResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
}