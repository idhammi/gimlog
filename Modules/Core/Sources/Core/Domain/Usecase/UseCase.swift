//
//  UseCase.swift
//  
//
//  Created by Idham on 08/12/21.
//

import Combine

public protocol UseCase {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
