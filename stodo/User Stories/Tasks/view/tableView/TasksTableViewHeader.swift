import UIKit

final class TasksTableViewHeader: UITableViewHeaderFooterView {
    let titleLabel: UILabel = UILabel()
    let addTaskTextField: UITextField = UITextField()
    weak var output: TaskTableViewHeaderOutput?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(tasks: [Task]?) {
        guard let tasks = tasks, tasks.count != 0 else {
            titleLabel.text = "Добавьте задачу"
            return
        }
        
        let completedTasks = tasks.filter { $0.status }
        titleLabel.text = "\(completedTasks.count) / \(tasks.count) задач"
    }
    
    private func configureContent() {
        contentView.backgroundColor = UIColor.white
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addTaskTextField.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = UIFont(name: "system", size: 14)
        addTaskTextField.font = UIFont(name: "system", size: 16)
        
        addTaskTextField.layer.cornerRadius = 5
        addTaskTextField.backgroundColor = UIColor(red: 0.88, green: 0.89, blue: 0.91, alpha: 0.68)
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        addTaskTextField.leftView = paddingView
        addTaskTextField.leftViewMode = .always
        addTaskTextField.placeholder = "+ Добавить todo"
        addTaskTextField.doneAccessory = true
        addTaskTextField.delegate = self
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(addTaskTextField)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -12),
            
            addTaskTextField.topAnchor.constraint(equalTo: titleLabel.layoutMarginsGuide.bottomAnchor, constant: 8),
            addTaskTextField.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 12),
            addTaskTextField.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -12),
            addTaskTextField.heightAnchor.constraint(equalToConstant: 40),
            addTaskTextField.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: 8)
        ])
    }
    
    private func didAddTask(with title: String?) {
        if let title = title {
            output?.didAddTask(with: title)
        }
    }
}


extension TasksTableViewHeader: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        didAddTask(with: textField.text)
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
