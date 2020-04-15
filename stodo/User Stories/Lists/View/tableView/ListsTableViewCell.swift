import UIKit

class ListsTableViewCell: UITableViewCell {

    @IBOutlet weak var colorPickerButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mockChartView: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        colorPickerButton.layer.cornerRadius = 4
        mockChartView.layer.cornerRadius = 4
        selectionStyle = .none
    }
    
    func configure(list: List) {
        titleLabel.text = list.title
        descriptionLabel.text = list.description
    }
    
}
