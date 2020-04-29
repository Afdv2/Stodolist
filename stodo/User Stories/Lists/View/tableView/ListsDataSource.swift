import UIKit

final class ListsDataSource: NSObject {
    weak var output: ListsDataSourceOutput?
    var lists: [List]?
    
    func configure(tableView: UITableView, output: ListsDataSourceOutput?) {
        self.output = output
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.register(ListsTableViewCell.nib, forCellReuseIdentifier: ListsTableViewCell.identifier)
    }
}

extension ListsDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let lists = lists else {
            return 0
        }
        
        return lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let lists = lists else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ListsTableViewCell.identifier, for: indexPath)
        
        guard let listsCell = cell as? ListsTableViewCell else {
            return cell
        }
        
        let list = lists[indexPath.row]
        listsCell.configure(list: list)
        
        return listsCell
    }
}

extension ListsDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.didSelectList(index: indexPath.row)
    }
}
