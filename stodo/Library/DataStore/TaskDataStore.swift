protocol TaskDataStore {
    func get(by listGuid: String) -> [Task]
    func put(taskResponse: TaskResponse, with listGuid: String)
    func put(taskResponses: [TaskResponse], with listGuid: String)
    func delete(guid: String)
}
