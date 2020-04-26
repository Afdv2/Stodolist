import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with task: Task) {
        if task.status {
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
        let color = UIColor(red: 0.54, green: 0.58, blue: 0.65, alpha: 1)
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: task.title)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSMakeRange(0, attributeString.length))
        titleLabel.attributedText = attributeString
        statusImage.image = UIImage(named: "checked")
    }
}
