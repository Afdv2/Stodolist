import UIKit
import Moya
import Dispatch

final class ListsViewController: UIViewController, ModuleTransitionable {
    
    var output: ListsViewOutput?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
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
        dataSource = ListsDataSource()
        dataSource.configure(tableView: tableView)
        
        addButton.layer.cornerRadius = addButton.frame.height / 2
        
        addButton.addTarget(self, action: #selector(addList), for: .touchUpInside)
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
    }
}
