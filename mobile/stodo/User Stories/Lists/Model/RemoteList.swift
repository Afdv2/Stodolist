import Foundation

struct RemoteList: Codable {
    let guid: String
    let title: String
    let summary: String?
    let tasks: [RemoteTask]?
    
    enum CodingKeys: String, CodingKey {
        case summary = "description"
        case guid
        case title
        case tasks
    }
    
    init(title: String, summary: String?) {
        self.guid = UUID().uuidString
        self.title = title
        self.summary = summary
        tasks = nil
    }
}
