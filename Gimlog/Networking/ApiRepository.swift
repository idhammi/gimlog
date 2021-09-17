//
//  ApiRepository.swift
//  Gimlog
//
//  Created by Idham on 17/09/21.
//

import Foundation

enum ApiResources: String {
    case games, creators, developers
}

struct ApiRepository {
    
    private let baseUrl = "api.rawg.io"
    private let apiKey = "5812fa28905c43af81a543cacd12a74b"
    
    private init() {}
    static let shared = ApiRepository()
    
    private let urlSession = URLSession.shared
    
    var urlComponents: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = baseUrl
        return urlComponents
    }
    
    func getGamesList(with resources: ApiResources, completion: @escaping(Data?, Error?) -> Void) {
        fetch(with: resources, parameters: nil, path: nil, completion: completion)
    }
    
    func getGameDetail(with resources: ApiResources, gameId: String, completion: @escaping(Data?, Error?) -> Void) {
        fetch(with: resources, parameters: nil, path: gameId, completion: completion)
    }
 
    private func fetch(with resources: ApiResources, parameters: [String: String]?, path: String?, completion: @escaping(Data?, Error?) -> Void) {
        var urlComponents = self.urlComponents
        
        if let appendPath = path {
            urlComponents.path = "/api/\(resources)/\(appendPath)"
        } else {
            urlComponents.path = "/api/\(resources)"
        }
        
        urlComponents.setQueryItems(with: ["key" : apiKey])
        if let params = parameters {urlComponents.setQueryItems(with: params)}
    
        guard let url = urlComponents.url else {
            completion(nil, NSError(domain: "", code: 100, userInfo: nil))
            return
        }
        urlSession.dataTask(with: url) { (data, _, error) in
            completion(data, error)
        }.resume()
    }

}

extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
    
}
