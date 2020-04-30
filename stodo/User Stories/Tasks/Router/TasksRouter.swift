final class TasksRouter: TasksRouterInput {
    weak var view: ModuleTransitionable?
    
    func closeModule() {
        view?.pop(animated: true)
    }
}
