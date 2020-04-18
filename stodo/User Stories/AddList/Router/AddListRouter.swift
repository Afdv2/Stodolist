class AddListRouter: AddListRouterInput {
    weak var view: ModuleTransitionable?
    
    func closeModule() {
        view?.dismissView(animated: true, completion: nil)
    }
}
