protocol TasksViewOutput: AnyObject {
    func didLoad()
    func backButtonDidTap()
    func didAddTask(with title: String)
}
