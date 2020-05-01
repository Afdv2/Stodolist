protocol TasksViewOutput: AnyObject {
    func didLoad()
    func backButtonDidTap()
    func didAddTask(with title: String)
    func didSelectTask(index: Int)
    func didRemoveTask(index: Int)
}
