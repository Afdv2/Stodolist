struct ListResponse: Codable {
    let guid: String
    let title: String
    let summary: String
    let tasks: [TaskResponse]
    
    enum CodingKeys: String, CodingKey {
        case summary = "description"
        case guid
        case title
        case tasks
    }
}
