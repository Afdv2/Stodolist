import Moya

struct ListsService: ListsServiceProtocol {
    
    private let listsProvider: MoyaProvider<ListsAPI>
    
    init(listsProvider: MoyaProvider<ListsAPI>) {
        self.listsProvider = listsProvider
    }
    
    func getLists(_ completion: @escaping (Result<ListsResponse, Error>) -> Void) {
        listsProvider.request(.all) { result in
            switch result {
            case .success(let response):
                do {
                    let jsonDecoder = JSONDecoder()
                    let listsResponse = try jsonDecoder.decode(ListsResponse.self, from: response.data)
                    completion(.success(listsResponse))
                } catch {
                    completion(.failure(LoadingDataError.decode(error.localizedDescription)))
                }
            case .failure(let error):
                completion(.failure(LoadingDataError.loading(error.localizedDescription)))
            }
        }
    }
    
    func putList(list: List, _ completion: @escaping (Result<ListResponse, Error>) -> Void) {
        listsProvider.request(.put(list: list)) { result in
            switch result {
            case .success(let response):
                do {
                let jsonDecoder = JSONDecoder()
                let listResponse = try jsonDecoder.decode(ListResponse.self, from: response.data)
                    completion(.success(listResponse))
                } catch {
                    completion(.failure(LoadingDataError.decode(error.localizedDescription)))
                }
            case .failure(let error):
                completion(.failure(LoadingDataError.loading(error.localizedDescription)))
            }
        }
    }
    
    func deleteList(id: String, _ completion: @escaping (Result<ListResponse, Error>) -> Void) {
        listsProvider.request(.delete(id: id)) { result in
            switch result {
            case .success(let response):
                do {
                    let jsonDecoder = JSONDecoder()
                    let listResponse = try jsonDecoder.decode(ListResponse.self, from: response.data)
                    completion(.success(listResponse))
                } catch {
                    completion(.failure(LoadingDataError.decode(error.localizedDescription)))
                }
            case .failure(let error):
                completion(.failure(LoadingDataError.loading(error.localizedDescription)))
            }
        }
    }
}
