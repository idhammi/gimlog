//
//  Inject.swift
//  Gimlog
//
//  Created by Idham on 10/12/21.
//

import Swinject

@propertyWrapper
struct Inject<Component> {
    let wrappedValue: Component
    init(_ name: String? = nil) {
        self.wrappedValue = Resolver.shared.resolve(Component.self, name: name)
    }
}
