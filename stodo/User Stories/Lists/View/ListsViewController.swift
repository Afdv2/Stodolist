import UIKit
import Moya

final class ListsViewController: UIViewController, ListsViewInput, ModuleTransitionable {
    var output: ListsViewOutput?
    
    @IBOutlet weak var tableView: UITableView!
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
    
    func set(title: String) {
        navigationItem.title = title
    }
    
    func set(lists: [List]) {
        dataSource.lists = lists
        tableView.reloadData()
    }
    
    private func setupView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        dataSource = ListsDataSource()
        dataSource.configure(tableView: tableView)
    }

}
