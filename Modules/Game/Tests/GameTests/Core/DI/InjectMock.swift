//
//  InjectMock.swift
//  
//
//  Created by Idham on 11/12/21.
//

import Swinject

@propertyWrapper
struct InjectMock<Component> {
    let wrappedValue: Component
    init(_ name: String? = nil) {
        self.wrappedValue = Resolver.shared.resolve(Component.self, name: name)
    }
}
