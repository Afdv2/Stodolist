final class ListsRouter: ListsRouterInput {
    
    weak var view: ModuleTransitionable?
    
    func showErrorModule(title: String, description: String) {
        print(title, description)
    }
    
    func showAddListModule(output: AddListModuleOutput?) {
        let addListModule = AddListConfigurator().configure(output: output)
        view?.presentModule(addListModule, animated: true, completion: nil)
    }
    
    func showListModule(with list: List) {
        let listModule = TasksConfigurator().configure(with: list, output: nil)
        view?.showModule(listModule)
    }
}
