import CoreData

final class CoreDataStack {
    
    static let shared = CoreDataStack()
    private init() {}
    
    lazy var container: NSPersistentContainer = {
        let c = NSPersistentContainer(name: coreDataModelName)
        c.loadPersistentStores { store, error in
            if let error = error {
                fatalError("CoreData error: \(error)")
            }
            print("Core Data Store url ->",store.url?.absoluteString)
        }
        c.viewContext.automaticallyMergesChangesFromParent = true
        return c
    }()
    
    lazy var context: NSManagedObjectContext = container.viewContext 
    
    func save() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            print("CoreDataStack save error -",error.localizedDescription)
        }
    }
}
