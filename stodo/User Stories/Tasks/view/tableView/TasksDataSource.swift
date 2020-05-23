import UIKit

final class TasksDataSource: NSObject {
    var tasks: [Task]?
    weak var output: TasksDataSourceOutput?
    
    init(tableView: UITableView) {
        tableView.register(TaskTableViewCell.nib, forCellReuseIdentifier: TaskTableViewCell.identifier)
        tableView.register(TasksTableViewHeader.self, forHeaderFooterViewReuseIdentifier: TasksTableViewHeader.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = 100
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        super.init()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension TasksDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tasks = tasks else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath)
        guard let taskCell = cell as? TaskTableViewCell else {
            return UITableViewCell()
        }
        
        taskCell.configure(with: tasks[indexPath.row])
        
        return taskCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks != nil ? tasks!.count : 0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        output?.didRemoveTask(index: indexPath.row)
    }
}

extension TasksDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TasksTableViewHeader.identifier)
        guard let taskTableHeader = header as? TasksTableViewHeader else {
            return nil
        }
        
        taskTableHeader.output = self
        taskTableHeader.configure(tasks: tasks)
        
        return taskTableHeader
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.didSelectTask(index: indexPath.row)
    }
}

extension TasksDataSource: TaskTableViewHeaderOutput {
    func didAddTask(with title: String) {
        output?.didAddTask(with: title)
    }
}
