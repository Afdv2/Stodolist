final class ListsRouter: ListsRouterInput {
    weak var view: ModuleTransitionable?
    
    func showError(title: String, description: String) {
        print(title, description)
    }
}
