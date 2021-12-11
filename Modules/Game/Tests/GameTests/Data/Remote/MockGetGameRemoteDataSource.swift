//
//  MockGetGameRemoteDataSource.swift
//  
//
//  Created by Idham on 11/12/21.
//

import Foundation
import Core
import Combine
import Game

public struct MockGetGameRemoteDataSource : DataSource {
    
    public typealias Request = [String: String]
    public typealias Response = GameResponse
    
    private let _endpoint: String
    
    public init(endpoint: String) {
        _endpoint = endpoint
    }
    
    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        
        return Future<GameResponse, Error> { completion in
            if request != nil {
                completion(.success(GameResponse.mockGame))
            } else {
                completion(.failure(URLError.invalidRequest))
            }
        }.eraseToAnyPublisher()
    }
}
