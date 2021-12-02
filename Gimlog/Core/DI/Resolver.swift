//
//  Resolver.swift
//  Gimlog
//
//  Created by Idham on 25/11/21.
//

import Swinject
import RealmSwift

@propertyWrapper
struct Inject<Component> {
    let wrappedValue: Component
    init() {
        self.wrappedValue = Resolver.shared.resolve(Component.self)
    }
}

class Resolver {
    static let shared = Resolver()
    private let container = buildContainer()
    
    func resolve<T>(_ type: T.Type) -> T {
        container.resolve(T.self)!
    }
}

func buildContainer() -> Container {
    let container = Container()
    let realm = try? Realm()
    
    container.register(RemoteDataSource.self) { _ in RemoteDataSource()}
    container.register(LocaleDataSource.self) { _ in LocaleDataSource(realm: realm)}
    
    container.register(GimlogRepositoryProtocol.self) { r in
        return GimlogRepository(
            locale: r.resolve(LocaleDataSource.self)!,
            remote: r.resolve(RemoteDataSource.self)!
        )
    }
    
    container.register(HomeUseCase.self) { r in
        return HomeInteractor(repository: r.resolve(GimlogRepositoryProtocol.self)!)
    }
    
    container.register(DetailUseCase.self) { r in
        return DetailInteractor(repository: r.resolve(GimlogRepositoryProtocol.self)!)
    }
    
    container.register(FavoriteUseCase.self) { r in
        return FavoriteInteractor(repository: r.resolve(GimlogRepositoryProtocol.self)!)
    }
    
    return container
}
