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
    
    func put(listResponse: RemoteList) -> List {
        let newList = List(context: container.viewContext)
        configure(list: newList, listResponse: listResponse)
        saveContext()
        
        return newList
    }
    
    func put(listResponses: [RemoteList]) -> [List] {
        var lists = [List]()
        for listResponse in listResponses {
            let newList = List(context: container.viewContext)
            configure(list: newList, listResponse: listResponse)
            lists.append(newList)
        }
        
        saveContext()
        
        return lists
    }
    
    func delete(list: List) {
        container.viewContext.delete(list)
        saveContext()
    }

    private func configure(list: List, listResponse: RemoteList) {
        list.guid = listResponse.guid
        list.title = listResponse.title
        list.summary = listResponse.summary ?? ""
    }
    
}
