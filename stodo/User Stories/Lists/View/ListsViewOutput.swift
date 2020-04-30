protocol ListsViewOutput: AnyObject {
    func viewLoaded()
    func didTapAddList()
    func didSelectList(_ index: Int)
    func didRemoveList(_ index: Int)
}
