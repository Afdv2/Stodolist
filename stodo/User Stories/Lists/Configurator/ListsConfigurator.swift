import Moya

final class ListsConfigurator {
    func configure(output: ListsModuleOutput? = nil) -> ListsViewController {
        let view = ListsViewController(nibName: "ListsViewController", bundle: nil)
        let presenter = ListsPresenter()
        let router = ListsRouter()
        let provider = MoyaProvider<ListsAPI>()
        let service = ListsService(listsProvider: provider)
        
        presenter.view = view
        presenter.router = router
        presenter.output = output
        presenter.service = service
        router.view = view
        
        view.output = presenter
        
        return view
    }
}
