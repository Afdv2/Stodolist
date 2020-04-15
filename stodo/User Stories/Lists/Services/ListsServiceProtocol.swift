protocol ListServiceProtocol {
    func getLists(_ completion: @escaping (_: Result<[List], LoadingDataError>) -> Void)
    func putList(list: List, _ completion: @escaping (_: LoadingDataError?) -> Void)
    func deleteList(id: String, _ completion: @escaping (_: LoadingDataError?) -> Void)
}
