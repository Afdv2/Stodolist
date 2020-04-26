protocol ListsServiceProtocol {
    func getLists(_ completion: @escaping (_: Result<ListsResponse, Error>) -> Void)
    func putList(list: List, _ completion: @escaping (_: Result<ListResponse, Error>) -> Void)
    func deleteList(id: String, _ completion: @escaping (_: Result<ListResponse, Error>) -> Void)
}
