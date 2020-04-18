final class ListsRouter: ListsRouterInput {
    weak var view: ModuleTransitionable?
    
    func showErrorModule(title: String, description: String) {
        print(title, description)
    }
    
    func showAddListModule(output: AddListModuleOutput?) {
        let addListModule = AddListConfigurator().configure(output: output)
        view?.presentModule(addListModule, animated: true, completion: nil)
    }
}
