//
//  GetGamesRemoteDataSource.swift
//  
//
//  Created by Idham on 08/12/21.
//

import Foundation
import Core
import Combine
import Alamofire

public struct GetGamesRemoteDataSource : DataSource {
    
    public typealias Request = [String: String]
    public typealias Response = [GameResponse]
    
    private let _endpoint: String
    
    public init(endpoint: String) {
        _endpoint = endpoint
    }
    
    public func execute(request: Request?) -> AnyPublisher<[GameResponse], Error> {
        return Future<[GameResponse], Error> { completion in
            
            guard let request = request else { return completion(.failure(URLError.invalidRequest)) }
            let params = ["key": request["key"]]
            
            if let url = URL(string: _endpoint) {
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
}
