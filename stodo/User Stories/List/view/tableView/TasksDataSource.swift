import UIKit

final class TasksDataSource: NSObject {
    var tasks: [Task]?
    let tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        configure()
    }
    
    private func configure() {
        tableView.dataSource = self
        tableView.register(TaskTableViewCell.nib, forCellReuseIdentifier: TaskTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
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
}
