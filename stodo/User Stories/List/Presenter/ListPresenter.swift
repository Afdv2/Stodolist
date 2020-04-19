final class ListPresenter {
    var output: ListModuleOutput?
    var view: ListViewInput?
    var router: ListRouter?
    let list: List
    
    init(list: List) {
        self.list = list
    }
}

extension ListPresenter: ListModuleInput {
    
}

extension ListPresenter: ListViewOutput {
    func didLoad() {
        view?.set(title: list.title)
        if let tasks = list.tasks {
            view?.set(tasks: tasks)
        }
    }
    
    func listsButtonDidTap() {
        router?.closeModule()
    }
}
