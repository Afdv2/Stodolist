import Moya

final class ListsConfigurator {
    func configure(shouldMock: Bool = false, output: ListsModuleOutput? = nil) -> ListsViewController {
        let view = ListsViewController(nibName: "ListsViewController", bundle: nil)
        let presenter = ListsPresenter()
        let router = ListsRouter()
        
        var provider: MoyaProvider<ListsAPI>
        if shouldMock {
            provider = MoyaProvider<ListsAPI>(stubClosure: MoyaProvider.delayedStub(1.0))
        } else {
            provider = MoyaProvider<ListsAPI>()
        }
        let service = ListsService(listsProvider: provider)
        
        let listDataStore = ListCoreDataStore()
        let taskDataStore = TaskCoreDataStore()
        
        presenter.view = view
        presenter.listDataStore = listDataStore
        presenter.taskDataStore = taskDataStore
        presenter.router = router
        presenter.output = output
        presenter.service = service
        router.view = view
        
        view.output = presenter
        
        return view
    }
}
