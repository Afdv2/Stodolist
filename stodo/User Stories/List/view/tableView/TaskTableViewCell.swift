import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with task: Task) {
        if let status = task.status, status {
            configureForCompletedTask(task)
        } else {
            configureForUncompletedTask(task)
        }
    }
    
    func configureForUncompletedTask(_ task: Task) {
        titleLabel.text = task.title
        statusImage.image = UIImage(named: "unchecked")
    }
    
    func configureForCompletedTask(_ task: Task) {
        if let title = task.title {
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: title)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            titleLabel.attributedText = attributeString
        }
        
        statusImage.image = UIImage(named: "checked")
    }
}
