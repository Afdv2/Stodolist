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
        
        let list = List()
        list.title = title
        list.summary = description ?? ""
        
        output?.didAdd(list: list)
        router?.closeModule()
    }
    
    func didTapCancel() {
        output?.didCancel()
        router?.closeModule()
    }
}
