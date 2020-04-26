import CoreData

struct ListCoreDataStore {
    private let container: NSPersistentContainer
    
    init() {
        self.container = CoreDataManager.shared.container
    }
    
    private func saveContext() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("An error occured while saving lists: \(error)")
            }
        }
    }
}

extension ListCoreDataStore: ListDataStore {
    func get() -> [List] {
        let listRequest = List.createFetchRequest()
        guard let lists = try? container.viewContext.fetch(listRequest) else {
            return []
        }

        return lists
    }
    
    func get(by guid: String) -> List? {
        let listRequest = List.createFetchRequest()
        listRequest.predicate = NSPredicate(format: "guid == %@", guid)
        guard let lists = try? container.viewContext.fetch(listRequest) else {
            return nil
        }

        return lists[0]
    }
    
    func put(listResponse: ListResponse) {
        let newList = List(context: container.viewContext)
        configure(list: newList, listResponse: listResponse)
        saveContext()
    }
    
    func put(listResponses: [ListResponse]) {
        for listResponse in listResponses {
            let newList = List(context: container.viewContext)
            configure(list: newList, listResponse: listResponse)
        }
        
        saveContext()
    }
    
    func delete(by guid: String) {
    }

    private func configure(list: List, listResponse: ListResponse) {
        list.guid = listResponse.guid
        list.title = listResponse.title
        list.summary = listResponse.summary
    }
    
}
