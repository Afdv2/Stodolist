final class TasksPresenter {
    var output: TasksModuleOutput?
    var view: TasksViewInput?
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
}
