final class AddListConfigurator {
    func configure(output: AddListModuleOutput?) -> AddListViewController {
        let presenter = AddListPresenter()
        let view = AddListViewController(nibName: "AddListViewController", bundle: nil)
        let router = AddListRouter()
        
        presenter.output = output
        presenter.view = view
        presenter.router = router
        router.view = view
        view.output = presenter
        
        return view
    }
}
