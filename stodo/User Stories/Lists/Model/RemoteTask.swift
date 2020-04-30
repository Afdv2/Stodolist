import Foundation

struct RemoteTask: Codable {
    let guid: String
    let title: String
    let status: Bool
    
    init(title: String) {
        self.guid = UUID().uuidString
        self.title = title
        self.status = false
    }
}
