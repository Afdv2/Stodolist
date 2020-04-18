import Foundation

final class ListsPresenter: ListsModuleInput {
    weak var view: ListsViewInput?
    var output: ListsModuleOutput?
    var router: ListsRouterInput?
    var service: ListsServiceProtocol?
    var lists: [List] = [] {
        didSet {
            view?.set(lists: lists)
        }
    }
    
    private func set(title: String) {
        view?.set(title: title)
    }
    
    private func loadLists() {
        service?.getLists({ [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let lists):
                self.lists.removeAll()
                self.lists.append(contentsOf: lists)
            case .failure(let error):
                self.router?.showErrorModule(title: "Ошибка загрузки проектов", description: error.localizedDescription)
            }
        })
    }
}

extension ListsPresenter: ListsViewOutput {
    func viewLoaded() {
        set(title: "Projects")
        loadLists()
    }
    
    func didTapAddList() {
        router?.showAddListModule(output: self)
    }
    
}

extension ListsPresenter: AddListModuleOutput {
    func didAdd(list: List) {
        self.lists.append(list)
        service?.putList(list: list, { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success:
                return
            case .failure(let error):
                self.router?.showErrorModule(title: "Ошибка обновления проекта", description: error.localizedDescription)
            }
        })
    }
    
    func didCancel() {
    }
    
    
}
