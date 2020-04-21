final class TasksPresenter {
    var output: TasksModuleOutput?
    var view: TasksViewInput?
    var router: TasksRouter?
    let list: List
    
    init(list: List) {
        self.list = list
    }
}

extension TasksPresenter: TasksModuleInput {
    
}

extension TasksPresenter: TasksViewOutput {
    func didLoad() {
        view?.set(title: list.title)
        view?.set(tasks: list.tasks)
    }
    
    func backButtonDidTap() {
        router?.closeModule()
    }
}
