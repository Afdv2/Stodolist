import CoreData

struct CoreDataManager {
    var container: NSPersistentContainer?
    mutating func configure() -> NSPersistentContainer {
        if let container = container {
            return container
        }
        
        self.container = NSPersistentContainer(name: "stodo")
        self.container?.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Error loading persistent store \(error)")
            }
        }
        
        return container!
    }
}
