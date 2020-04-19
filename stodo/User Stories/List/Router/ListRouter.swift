final class ListRouter: ListRouterInput {
    var view: ModuleTransitionable?
    
    func closeModule() {
        view?.pop(animated: true)
    }
}
