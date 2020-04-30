protocol TasksViewOutput: AnyObject {
    func didLoad()
    func backButtonDidTap()
    func didAddTask(with title: String)
    func didSelectTask(by index: Int)
}
