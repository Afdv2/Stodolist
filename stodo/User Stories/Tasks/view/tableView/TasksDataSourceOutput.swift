protocol TasksDataSourceOutput: AnyObject {
    func didAddTask(with title: String)
    func didSelectTask(index: Int)
    func didRemoveTask(index: Int)
}
