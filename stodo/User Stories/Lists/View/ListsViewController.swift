import UIKit
import Moya
import Dispatch

final class ListsViewController: UIViewController, ModuleTransitionable {
    
    @IBOutlet weak var writingGirlImageView: UIImageView!
    var output: ListsViewOutput?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var addProjectLabel: UILabel!
    var dataSource: ListsDataSource!
    
    static func create(nibName: String? = nil, bundle: Bundle? = nil) -> ListsViewController {
        if nibName == nil {
            let className = String(describing: ListsViewController.self)
            return ListsViewController(nibName: className, bundle: bundle)
        }
        
         return ListsViewController(nibName: nibName, bundle: bundle)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        output?.viewLoaded()
    }
    
    private func setupView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        checkNeedShowAddProjectNotification()
        dataSource = ListsDataSource(tableView: tableView, output: self)
        addButton.layer.cornerRadius = addButton.frame.height / 2
        addButton.addTarget(self, action: #selector(addList), for: .touchUpInside)
    }
    
    private func checkNeedShowAddProjectNotification(_ withAnimation: Bool = false) {
        let duration = withAnimation ? 0.1 : 0
        UIView.animate(withDuration: duration) { [unowned self] in
            let existsLists = self.dataSource?.lists?.count != 0
            self.writingGirlImageView.alpha = existsLists ? 0 : 1
            self.addProjectLabel.alpha =  existsLists ? 0 : 1
            self.navigationController?.navigationBar.isHidden = !existsLists
            self.tableView.isHidden = !existsLists
        }
    }
    
    @objc
    private func addList() {
        output?.didTapAddList()
    }
}

extension ListsViewController: ListsViewInput {
    func set(title: String) {
        navigationItem.title = title
    }
    
    func set(lists: [List]) {
        dataSource.lists = lists
        tableView.reloadData()
        checkNeedShowAddProjectNotification(true)
    }
}

extension ListsViewController: ListsDataSourceOutput {
    func didSelectList(_ index: Int) {
        output?.didSelectList(index)
    }
    
    func didRemoveList(_ index: Int) {
        output?.didRemoveList(index)
    }
}
