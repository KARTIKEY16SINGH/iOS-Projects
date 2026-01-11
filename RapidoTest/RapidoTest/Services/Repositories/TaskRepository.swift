//
//  TaskRepository.swift
//  RapidoTest
//
//  Created by Iron Man on 10/01/26.
//

import CoreData
import Foundation

protocol TaskRepositoryable {
    func addTask(task: Task)
    func getAll() -> [Task]
    func delete(id: UUID)
    func update(task: Task)
}


struct TaskRepository: TaskRepositoryable {
    private let persistenceStorage: Persistencable
    private let dataModifier: TaskModifiable
    
    init(persistenceStorage: Persistencable, dataModifier: TaskModifiable) {
        self.persistenceStorage = persistenceStorage
        self.dataModifier = dataModifier
    }
    
    func addTask(task: Task) {
        let storeTask = CDTask(context: persistenceStorage.viewContext)
        dataModifier.mapToStore(storeTask: storeTask, task: task)
        persistenceStorage.saveContext()
    }
    
    func update(task: Task) {
        let fetchRequest = CDTask.fetchRequest()
        fetchRequest.predicate = getPredicate(for: task.id)
        do {
            let result = try persistenceStorage.viewContext.fetch(fetchRequest)
            guard let storeTask = result.first else { return }
            dataModifier.mapToStore(storeTask: storeTask, task: task)
            persistenceStorage.saveContext()
        } catch {
            debugPrint(error)
        }
    }
    
    func delete(id: UUID) {
        let fetchRequest = CDTask.fetchRequest()
        fetchRequest.predicate = getPredicate(for: id)
        do {
            let result = try persistenceStorage.viewContext.fetch(fetchRequest)
            result.forEach(persistenceStorage.viewContext.delete)
            persistenceStorage.saveContext()
        } catch {
            debugPrint(error)
        }
    }
    
    func getAll() -> [Task] {
        do {
            let result = try persistenceStorage.viewContext.fetch(CDTask.fetchRequest())
            return result.map(dataModifier.convertFromStore(task:))
        } catch {
            debugPrint(error.localizedDescription)
        }
        return []
    }
    
    private func getPredicate(for id: UUID) -> NSPredicate {
        NSPredicate(format: "id==%@", id as CVarArg)
    }
}
