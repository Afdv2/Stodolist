import CoreData

struct TaskCoreDataStore {
    private let container: NSPersistentContainer
    
    init() {
        self.container = CoreDataManager.shared.container
    }
    
    func saveContext() {
        guard container.viewContext.hasChanges else {
            return
        }

        do {
            try container.viewContext.save()
        } catch {
            print("An error occured while saving tasks: \(error)")
        }
    }
}

extension TaskCoreDataStore: TaskDataStore {
    
    func get(by listGuid: String) -> [Task] {
        let taskRequest = Task.createFetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "status", ascending: true)
        taskRequest.sortDescriptors = [sortDescriptor]
        taskRequest.predicate = NSPredicate(format: "list.guid == %@", listGuid)
        guard let tasks = try? container.viewContext.fetch(taskRequest) else {
            return []
        }

        return tasks
    }
    
    func put(taskResponse: RemoteTask, with listGuid: String) {
        let newTask = Task(context: container.viewContext)
        configure(task: newTask, taskResponse: taskResponse, with: listGuid)
        saveContext()
    }
    
    func put(taskResponses: [RemoteTask], with listGuid: String) {
        for taskResponse in taskResponses {
            let newTask = Task(context: container.viewContext)
            configure(task: newTask, taskResponse: taskResponse, with: listGuid)
        }
        saveContext()
    }
    
    func delete(guid: String) {
    }
    
    private func configure(task: Task, taskResponse: RemoteTask, with listGuid: String) {
        task.guid = taskResponse.guid
        task.title = taskResponse.title
        task.status = taskResponse.status

        let listRequest = List.createFetchRequest()
        listRequest.predicate = NSPredicate(format: "guid == %@", listGuid)
        guard let lists = try? container.viewContext.fetch(listRequest) else {
            fatalError("task must have a parrent list")
        }

        task.list = lists[0]
    }
}
