import Foundation

struct List: Codable {
    var guid: String?
    var title: String?
    var description: String?
    var color: String?
    var tasks: [Task]?
    
    init() {
        self.guid = UUID().uuidString
    }
}
