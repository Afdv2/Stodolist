final class AddListPresenter {
    var output: AddListModuleOutput?
    weak var view: AddListViewInput?
    var router: AddListRouterInput?
}

extension AddListPresenter: AddListViewOutput {
    func didTapCreateList(title: String?, description: String?) {
        guard let title = title, title != "" else {
            print("list can't be created without title")
            return
        }
        
        output?.didAddList(title: title, description: description)
        router?.closeModule()
    }
    
    func didTapCancel() {
        router?.closeModule()
    }
}
