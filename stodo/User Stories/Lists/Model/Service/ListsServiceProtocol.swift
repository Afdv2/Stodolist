protocol ListsServiceProtocol {
    func getLists(_ completion: @escaping (_: Result<[List], Error>) -> Void)
    func putList(list: List, _ completion: @escaping (_: Result<List, Error>) -> Void)
    func deleteList(id: String, _ completion: @escaping (_: Result<String, Error>) -> Void)
}
