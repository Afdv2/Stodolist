import Moya

struct ListService: ListServiceProtocol {
    private let listsProvider: MoyaProvider<ListsAPI>
    
    init(listsProvider: MoyaProvider<ListsAPI>) {
        self.listsProvider = listsProvider
    }
    
    func getLists(_ completion: @escaping (Result<[List], LoadingDataError>) -> Void) {
        listsProvider.request(.all) { result in
            switch result {
            case .success(let response):
                do {
                    let jsonDecoder = JSONDecoder()
                    let listsResponse = try jsonDecoder.decode(ListsResponse.self, from: response.data)
                    guard let lists = listsResponse.lists else {
                        completion(.failure(.emptyData))
                        return
                    }
                    completion(.success(lists))
                } catch {
                    completion(.failure(.decode(error.localizedDescription)))
                }
            case .failure(let error):
                completion(.failure(.loading(error.localizedDescription)))
            }
        }
    }
    
    func putList(list: List, _ completion: @escaping (LoadingDataError?) -> Void) {
        listsProvider.request(.put(list: list)) { result in
            switch result {
            case .success:
                completion(nil)
            case .failure(let error):
                completion(.loading(error.localizedDescription))
            }
        }
    }
    
    func deleteList(id: String, _ completion: @escaping (LoadingDataError?) -> Void) {
        listsProvider.request(.delete(id: id)) { result in
            switch result {
            case .success:
                completion(nil)
            case .failure(let error):
                completion(.loading(error.localizedDescription))
            }
        }
    }
}
