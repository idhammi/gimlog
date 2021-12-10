//
//  GetGameRemoteDataSource.swift
//  
//
//  Created by Idham on 08/12/21.
//

import Foundation
import Core
import Combine
import Alamofire

public struct GetGameRemoteDataSource : DataSource {
    
    public typealias Request = [String: String]
    public typealias Response = GameResponse
    
    private let _endpoint: String
    
    public init(endpoint: String) {
        _endpoint = endpoint
    }
    
    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        
        return Future<GameResponse, Error> { completion in
            
            guard let request = request else { return completion(.failure(URLError.invalidRequest)) }
            guard let path = request["id"] else { return completion(.failure(URLError.invalidRequest)) }
            let params = ["key": request["key"]]
            
            if let url = URL(string: _endpoint + path) {
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
