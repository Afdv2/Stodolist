final class TasksRouter: TasksRouterInput {
    var view: ModuleTransitionable?
    
    func closeModule() {
        view?.pop(animated: true)
    }
}
