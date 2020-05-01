import Foundation
import TTGSnackbar

final class ListsPresenter: ListsModuleInput {
    weak var view: ListsViewInput?
    var output: ListsModuleOutput?
    var router: ListsRouterInput?
    var listService: ListsServiceProtocol?
    var listDataStore: ListDataStore?
    var taskDataStore: TaskDataStore?
    var lists: [List] = [] {
        didSet {
            view?.set(lists: lists)
        }
    }
    
    private func loadLocalLists() {
        if let lists = listDataStore?.get() {
            self.lists = lists
        }
    }
    
    private func fetchRemoteLists(_ completion: @escaping (Bool) -> Void) {
        listService?.getLists({ result in
            switch result {
            case .success(let listsResponse):
                self.save(listsResponse: listsResponse)
                completion(true)
            case .failure(let error):
                self.router?.showErrorModule(title: "Ошибка загрузки проектов", description: error.localizedDescription)
                completion(false)
            }
        })
    }
    
    private func save(listsResponse: ListsResponse?) {
        guard let listsResponse = listsResponse, let lists = listsResponse.lists else {
            return
        }
        
        save(lists: lists)
    }
    
    private func save(lists: [RemoteList]) {
        _ = listDataStore?.put(listResponses: lists)
        for list in lists {
            if let tasks = list.tasks {
                taskDataStore?.put(taskResponses: tasks, with: list.guid)
            }
        }
    }
    
    private func undo(message: String, actionText: String) {
        let snackbar = TTGSnackbar(
            message: message,
            duration: .middle,
            actionText: actionText,
            actionBlock: { [unowned self] snackbar in
                self.listDataStore?.undo()
                self.loadLocalLists()
            }
        )
        snackbar.show()
    }
}

extension ListsPresenter: ListsViewOutput {
    
    func viewLoaded() {
        view?.set(title: "Проекты")
        loadLocalLists()
        fetchRemoteLists() { [unowned self] success in
            if success {
                self.loadLocalLists()
            }
        }
    }
    
    func didTapAddList() {
        router?.showAddListModule(output: self)
    }
    
    func didSelectList(_ index: Int) {
        let list = lists[index]
        router?.showListModule(with: list, output: self)
    }
    
    func didRemoveList(_ index: Int) {
        let list = lists[index]
        let title = list.title
        listDataStore?.delete(list: list)
        loadLocalLists()
        undo(message: "Вернуть проект \(title)", actionText: "Отмена")
    }
}

extension ListsPresenter: AddListModuleOutput {
    func didAddList(title: String, description: String?) {
        let listResponse = RemoteList(title: title, summary: description)
        save(lists: [listResponse])
        loadLocalLists()
    }
}

extension ListsPresenter: TasksModuleOutput {
    func didAddTask() {
        loadLocalLists()
    }
}
