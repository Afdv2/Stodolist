import Foundation

final class ListsPresenter: ListsModuleInput {
    weak var view: ListsViewInput?
    var output: ListsModuleOutput?
    var router: ListsRouterInput?
    var service: ListsServiceProtocol?
    var listDataStore: ListDataStore?
    var taskDataStore: TaskDataStore?
    var lists: [List] = [] {
        didSet {
            view?.set(lists: lists)
        }
    }
    
    private func set(title: String) {
        view?.set(title: title)
    }
    
    private func loadLocalLists() {
        if let lists = listDataStore?.get() {
            self.lists = lists
        }
    }
    
    private func fetchRemoteLists() {
        service?.getLists({ result in
            switch result {
            case .success(let listsResponse):
                self.saveLists(listsResponse)
                self.loadLocalLists()
            case .failure(let error):
                self.router?.showErrorModule(title: "Ошибка загрузки проектов", description: error.localizedDescription)
            }
        })
    }
    
    private func saveLists(_ listsResponse: ListsResponse?) {
        guard let listsResponse = listsResponse, let lists = listsResponse.lists else {
            return
        }
        
        listDataStore?.put(listResponses: lists)
        
        for list in lists {
            saveRemoteTasks(listGUID: list.guid, taskResponses: list.tasks)
        }
    }
    
    private func saveRemoteTasks(listGUID: String, taskResponses: [TaskResponse]?) {
        guard let taskResponses = taskResponses else {
            return
        }
        
        taskDataStore?.put(taskResponses: taskResponses, with: listGUID)
    }
}

extension ListsPresenter: ListsViewOutput {
    func viewLoaded() {
        set(title: "Projects")
        loadLocalLists()
        fetchRemoteLists()
    }
    
    func didTapAddList() {
        router?.showAddListModule(output: self)
    }
    
    func didSelect(list: List) {
        router?.showListModule(with: list)
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
