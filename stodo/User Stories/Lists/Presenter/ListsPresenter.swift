import Foundation

final class ListsPresenter: ListsViewOutput, ListsModuleInput {
    weak var view: ListsViewInput?
    var output: ListsModuleOutput?
    var router: ListsRouterInput?
    var service: ListsServiceProtocol?
    
    func viewLoaded() {
        set(title: "Projects")
        loadLists()
    }
    
    private func set(title: String) {
        view?.set(title: title)
    }
    
    private func loadLists() {
        service?.getLists({ [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let lists):
                self.view?.set(lists: lists)
            case .failure(let error):
                self.router?.showError(title: "Ошибка загрузки проектов", description: error.localizedDescription)
            }
        })
    }
}
