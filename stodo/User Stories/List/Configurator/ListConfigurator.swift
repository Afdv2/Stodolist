final class ListConfigurator {
    func configure(with list: List, output: ListModuleOutput?) -> ListViewController {
        let view = ListViewController(nibName: "ListViewController", bundle: nil)
        let presenter = ListPresenter(list: list)
        let router = ListRouter()
        
        presenter.output = output
        presenter.view = view
        presenter.router = router
        
        router.view = view
        view.output = presenter
        
        return view
    }
}
