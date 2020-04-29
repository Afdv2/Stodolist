protocol ListsViewOutput: AnyObject {
    func viewLoaded()
    func didTapAddList()
    func didSelectList(index: Int)
}
