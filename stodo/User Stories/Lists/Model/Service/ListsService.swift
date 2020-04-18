import Moya

struct ListsService: ListsServiceProtocol {
    
    private let listsProvider: MoyaProvider<ListsAPI>
    
    init(listsProvider: MoyaProvider<ListsAPI>) {
        self.listsProvider = listsProvider
    }
    
    func getLists(_ completion: @escaping (Result<[List], Error>) -> Void) {
        listsProvider.request(.all) { result in
            switch result {
            case .success(let response):
                do {
                    let jsonDecoder = JSONDecoder()
                    let listsResponse = try jsonDecoder.decode(ListsResponse.self, from: response.data)
                    guard let lists = listsResponse.lists else {
                        completion(.failure(LoadingDataError.emptyData))
                        return
                    }
                    completion(.success(lists))
                } catch {
                    completion(.failure(LoadingDataError.decode(error.localizedDescription)))
                }
            case .failure(let error):
                completion(.failure(LoadingDataError.loading(error.localizedDescription)))
            }
        }
    }
    
    func putList(list: List, _ completion: @escaping (Result<List, Error>) -> Void) {
        listsProvider.request(.put(list: list)) { result in
            switch result {
            case .success:
                completion(.success(list))
            case .failure(let error):
                completion(.failure(LoadingDataError.loading(error.localizedDescription)))
            }
        }
    }
    
    func deleteList(id: String, _ completion: @escaping (Result<String, Error>) -> Void) {
        listsProvider.request(.delete(id: id)) { result in
            switch result {
            case .success:
                completion(.success(id))
            case .failure(let error):
                completion(.failure(LoadingDataError.loading(error.localizedDescription)))
            }
        }
    }
}
