protocol ListsViewOutput: AnyObject {
    func viewLoaded()
    func didTapAddList()
    func didSelect(list: List)
}
