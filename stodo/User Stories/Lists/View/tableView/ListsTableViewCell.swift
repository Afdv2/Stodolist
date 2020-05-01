import UIKit
import Charts

class ListsTableViewCell: UITableViewCell {

    @IBOutlet weak var colorPickerButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mockChartView: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    var chartView: PieChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colorPickerButton.layer.cornerRadius = 4
        selectionStyle = .none
        initChartView()
    }
    
    private func initChartView() {
        let chartViewFrame = CGRect(x: 0, y: 0, width: mockChartView.frame.width, height: mockChartView.frame.height)
        chartView = PieChartView(frame: chartViewFrame)
        chartView.setExtraOffsets(left: 0, top: 0, right: 0, bottom: 0)
        mockChartView.addSubview(chartView)
        
        chartView.holeColor = UIColor.clear
        chartView.rotationAngle = 90
        chartView.holeRadiusPercent = 0.55
        chartView.legend.enabled = false
        chartView.isUserInteractionEnabled = false
    }
    
    func configure(list: List) {
        titleLabel.text = list.title
        descriptionLabel.text = list.summary
        
        let completedTasks = list.tasks.filter { $0.status }
        progressLabel.text = "\(completedTasks.count) / \(list.tasks.count)"
        setChartData(by: list)
    }
    
    private func setChartData(by list: List) {
        let completedTasks = list.tasks.filter { $0.status }
        let uncompletedTasksCount = list.tasks.count - completedTasks.count
        let completedTasksDataEntry = PieChartDataEntry(value: Double(completedTasks.count), label: nil)
        let uncompletedTasksDataEntry = PieChartDataEntry(value: Double(uncompletedTasksCount), label: nil)
        
        let set = PieChartDataSet(entries: [uncompletedTasksDataEntry, completedTasksDataEntry])
        set.selectionShift = 0
        set.drawValuesEnabled = false
        set.drawIconsEnabled = false
        if #available(iOS 13.0, *) {
            set.colors = [UIColor.lightGray, UIColor.systemIndigo]
        } else {
            // Fallback on earlier versions
        }
        
        let data = PieChartData(dataSet: set)
        chartView.data = data
        
    }
    
}
