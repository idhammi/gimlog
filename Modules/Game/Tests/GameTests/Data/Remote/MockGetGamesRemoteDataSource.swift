//
//  MockGetGamesRemoteDataSource.swift
//  
//
//  Created by Idham on 11/12/21.
//

import Foundation
import Core
import Combine
import Game

public struct MockGetGamesRemoteDataSource : DataSource {
    
    public typealias Request = [String: String]
    public typealias Response = [GameResponse]
    
    private let _endpoint: String
    
    public init(endpoint: String) {
        _endpoint = endpoint
    }
    
    public func execute(request: Request?) -> AnyPublisher<[GameResponse], Error> {
        return Future<[GameResponse], Error> { completion in
            if request != nil {
                completion(.success(GameResponse.mockGames))
            } else {
                completion(.failure(URLError.invalidRequest))
            }
        }.eraseToAnyPublisher()
    }
}
