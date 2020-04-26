import CoreData

struct CoreDataManager {
    static var shared = CoreDataManager()
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "stodo")
        container.loadPersistentStores { (description, error) in
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        
        return container
    }()
}
