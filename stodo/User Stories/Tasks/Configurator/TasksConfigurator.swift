final class TasksConfigurator {
    func configure(with list: List, output: TasksModuleOutput?) -> TasksViewController {
        let view = TasksViewController(nibName: "TasksViewController", bundle: nil)
        let presenter = TasksPresenter(list: list)
        let router = TasksRouter()
        
        presenter.output = output
        presenter.view = view
        presenter.router = router
        
        router.view = view
        view.output = presenter
        
        return view
    }
}
