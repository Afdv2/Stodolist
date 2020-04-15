import Foundation

final class ListsPresenter: ListsViewOutput, ListsModuleInput {
    weak var view: ListsViewInput?
    var output: ListsModuleOutput?
    var router: ListsRouterInput?
    var service: ListsServiceProtocol?
}
