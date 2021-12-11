//
//  Resolver.swift
//  Gimlog
//
//  Created by Idham on 25/11/21.
//

import Swinject

class Resolver {
    static let shared = Resolver()
    private let container = Container()
    private let assembler: Assembler
    
    init() {
        assembler = Assembler(
            [
                AppAssembly(),
                DataSourceAssembly(),
                TransformerAssembly(),
                RepositoryAssembly(),
                UseCaseAssembly()
            ], container: container
        )
    }
    
    func resolve<T>(_ type: T.Type, name: String?) -> T {
        container.resolve(T.self, name: name)!
    }
}
