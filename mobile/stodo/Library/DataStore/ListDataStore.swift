protocol ListDataStore {
    func get() -> [List]
    func get(by guid: String) -> List?
    func put(listResponse: RemoteList) -> List
    func put(listResponses: [RemoteList]) -> [List]
    func delete(list: List)
    func undo()
}
