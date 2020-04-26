protocol ListDataStore {
    func get() -> [List]
    func get(by guid: String) -> List?
    func put(listResponse: ListResponse)
    func put(listResponses: [ListResponse])
    func delete(by guid: String)
}
