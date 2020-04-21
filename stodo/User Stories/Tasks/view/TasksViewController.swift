import UIKit
import Dispatch

final class TasksViewController: UIViewController, ModuleTransitionable {
    var output: TasksViewOutput?
    var dataSource: TasksDataSource?

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        output?.didLoad()
    }

    private func setupView() {
        navigationItem.largeTitleDisplayMode = .always
        
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "lists"), style: .plain, target: self, action: #selector(backButtonDidTap))
        if #available(iOS 13.0, *) {
            leftBarButtonItem.tintColor = UIColor.systemIndigo
        } else {
            // Fallback on earlier versions
        }
        navigationItem.leftBarButtonItem = leftBarButtonItem

        dataSource = TasksDataSource(tableView: tableView)
    }
    
    @objc
    private func backButtonDidTap() {
        output?.backButtonDidTap()
    }
}

extension TasksViewController: TasksViewInput {
    func set(title: String?) {
        navigationItem.title = title
    }
    
    func set(tasks: [Task]?) {
        dataSource?.tasks = tasks
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
