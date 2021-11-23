//
//  GameProvider.swift
//  Gimlog
//
//  Created by Idham on 28/09/21.
//

import CoreData

class GameProvider {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Gimlog")
        
        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("Unresolved error \(error!)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil
        
        return container
    }()
    
    private func newTaskContext() -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil
        
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }
    
//    func getAllGame(completion: @escaping(_ games: [GameModel]) -> Void) {
//        let taskContext = newTaskContext()
//        taskContext.perform {
//            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Game")
//            do {
//                let results = try taskContext.fetch(fetchRequest)
//                var games: [GameModel] = []
//                for result in results {
//                    let member = GameModel(
//                        id: result.value(forKeyPath: "id") as? Int,
//                        name: result.value(forKeyPath: "name") as? String,
//                        released: result.value(forKeyPath: "released") as? String,
//                        backgroundImage: result.value(forKeyPath: "backgroundImage") as? String,
//                        rating: result.value(forKeyPath: "rating") as? Float
//                    )
//
//                    games.append(member)
//                }
//                completion(games)
//            } catch let error as NSError {
//                print("Could not fetch. \(error), \(error.userInfo)")
//            }
//        }
//    }
    
//    func getGame(_ id: Int, completion: @escaping(_ game: GameModel) -> Void) {
//        let taskContext = newTaskContext()
//        taskContext.perform {
//            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Game")
//            fetchRequest.fetchLimit = 1
//            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
//            do {
//                if let result = try taskContext.fetch(fetchRequest).first {
//                    let game = GameModel(
//                        id: result.value(forKeyPath: "id") as? Int,
//                        name: result.value(forKeyPath: "name") as? String,
//                        released: result.value(forKeyPath: "released") as? String,
//                        backgroundImage: result.value(forKeyPath: "backgroundImage") as? String,
//                        rating: result.value(forKeyPath: "rating") as? Float
//                    )
//
//                    completion(game)
//                }
//            } catch let error as NSError {
//                print("Could not fetch. \(error), \(error.userInfo)")
//            }
//        }
//    }
    
    func insertGame(_ item: GameModel, completion: @escaping() -> Void) {
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: "Game", in: taskContext) {
                let game = NSManagedObject(entity: entity, insertInto: taskContext)
                game.setValue(item.id, forKeyPath: "id")
                game.setValue(item.name, forKeyPath: "name")
                game.setValue(item.released, forKeyPath: "released")
                game.setValue(item.backgroundImage, forKeyPath: "backgroundImage")
                game.setValue(item.rating, forKeyPath: "rating")
                
                do {
                    try taskContext.save()
                    completion()
                } catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
        }
    }
    
    func deleteGame(_ id: Int, completion: @escaping() -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
                if batchDeleteResult.result != nil {
                    completion()
                }
            }
        }
    }
    
    func checkGameExist(_ id: Int, completion: @escaping(_ isExist: Bool) -> Void) {
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Game")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "id == \(id)")
            do {
                let game = try taskContext.fetch(fetchRequest)
                if game.count > 0 {
                    completion(true)
                } else {
                    completion(false)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
