protocol TaskDataStore {
    func get(by listGuid: String) -> [Task]
    func put(taskResponse: RemoteTask, with listGuid: String)
    func put(title: String, with listGuid: String)
    func change(guid: String, by status: Bool)
    func put(taskResponses: [RemoteTask], with listGuid: String)
    func delete(guid: String)
}
