protocol TasksDataSourceOutput: AnyObject {
    func didAddTask(with title: String)
    func didSelectTask(by index: Int)
}
