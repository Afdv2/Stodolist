import Moya

enum ListsAPI {
    case all
    case put(list: List)
    case delete(id: String)
}

extension ListsAPI: TargetType {
    var baseURL: URL {
        return URL(string: Constants.API_URL)!
    }
    
    var path: String {
        switch self {
            case .all,
                .put:
                return "lists"
            case .delete(let id):
                return "lists/\(id)"
            }
    }
    
    var method: Moya.Method {
        switch self {
            case .all,
                 .delete:
                return .get
            case .put:
                return .put
            }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json; charset=UTF-8"]
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    var sampleData: Data {
        switch self {
        case .all:
            return "{\"lists\":[{\"guid\":\"1\",\"title\":\"list1\",\"tasks\":[{\"guid\":\"100\",\"title\":\"task100\",\"status\":false},{\"guid\":\"101\",\"title\":\"task101\",\"status\":true}]},{\"guid\":\"2\",\"title\":\"list2\",\"tasks\":[{\"guid\":\"200\",\"title\":\"task200\",\"status\":true},{\"guid\":\"201\",\"title\":\"task201\",\"status\":false}]}]}".dataEncoded
        case .put( _):
            return "empty".dataEncoded
        case .delete(id: _):
            return "empty".dataEncoded
        }
    }
}
