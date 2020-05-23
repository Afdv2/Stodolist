import UIKit
import Dispatch

final class TasksViewController: UIViewController, ModuleTransitionable {
    var output: TasksViewOutput?
    var dataSource: TasksDataSource!

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
        dataSource.output = self
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
        dataSource.tasks = tasks
        DispatchQueue.main.async {
            self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
    }
}

extension TasksViewController: TasksDataSourceOutput {
    func didAddTask(with title: String) {
        output?.didAddTask(with: title)
    }
    
    func didSelectTask(index: Int) {
        output?.didSelectTask(index: index)
    }
    
    func didRemoveTask(index: Int) {
        output?.didRemoveTask(index: index)
    }
}
