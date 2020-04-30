protocol TasksViewInput: AnyObject {
    func set(title: String?)
    func set(tasks: [Task]?)
}
