final class TasksPresenter {
    weak var view: TasksViewInput?
    var output: TasksModuleOutput?
    var router: TasksRouter?
    var taskDataStore: TaskDataStore?
    let list: List
    var tasks: [Task]? {
        didSet {
            view?.set(tasks: tasks)
        }
    }
    
    init(list: List) {
        self.list = list
    }
    
    func loadLocalTasks() {
        tasks = taskDataStore?.get(by: list.guid)
    }
    
    func addTask(with title: String) {
        taskDataStore?.put(title: title, with: list.guid)
        output?.didAddTask()
    }
    
    func removeTask(index: Int) {
        guard let task = tasks?[index] else { return }
        taskDataStore?.delete(task: task)
    }
    
    func invertStatusTask(by index: Int) {
        guard let task = tasks?[index] else { return }
        taskDataStore?.change(guid: task.guid, by: !task.status)
    }
}

extension TasksPresenter: TasksModuleInput {
    
}

extension TasksPresenter: TasksViewOutput {
    func didLoad() {
        view?.set(title: list.title)
        loadLocalTasks()
    }
    
    func backButtonDidTap() {
        router?.closeModule()
    }
    
    func didAddTask(with title: String) {
        addTask(with: title)
        loadLocalTasks()
    }
    
    func didSelectTask(index: Int) {
        invertStatusTask(by: index)
        loadLocalTasks()
    }
    
    func didRemoveTask(index: Int) {
        removeTask(index: index)
        loadLocalTasks()
    }
}
