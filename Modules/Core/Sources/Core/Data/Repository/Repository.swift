//
//  Repository.swift
//  
//
//  Created by Idham on 08/12/21.
//

import Combine

public protocol Repository {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
