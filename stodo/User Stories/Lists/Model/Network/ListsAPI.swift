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
        case .all:
            return .get
        case .put:
            return .put
        case .delete:
            return .delete
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
            return "{\"lists\":[{\"guid\":\"1\",\"title\":\"Создать приложение Stodolist\",\"description\":\"приложение для планирования задач\",\"tasks\":[{\"guid\":\"100\",\"title\":\"создать прототип проекта\",\"status\":false},{\"guid\":\"101\",\"title\":\"создать дизайн\",\"status\":true}]},{\"guid\":\"2\",\"title\":\"Выучить английский\",\"description\":\"Поступить в университет в Великобритании\",\"tasks\":[{\"guid\":\"200\",\"title\":\"Собрать документы на визу\",\"status\":true},{\"guid\":\"201\",\"title\":\"Собрать документы на оформление квартиры\",\"status\":false}]}]}".dataEncoded
        case .put( _):
            return "empty".dataEncoded
        case .delete(id: _):
            return "empty".dataEncoded
        }
    }
}
