import UIKit
import Dispatch

class AddListViewController: UIViewController, ModuleTransitionable {
    var output: AddListViewOutput?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        createButton.layer.cornerRadius = createButton.frame.height / 2
        cancelButton.layer.cornerRadius = cancelButton.frame.height / 2
        
        descriptionTextView.layer.cornerRadius = 4
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor(hexString: "cccccc").cgColor
        
        
        createButton.addTarget(self, action: #selector(createList), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
    }
    
    @objc
    private func createList() {
        DispatchQueue.main.async {
            self.output?.didTapCreateList(title: self.titleTextField.text, description: self.descriptionTextView.text)
        }
    }
    
    @objc
    private func cancel() {
        DispatchQueue.main.async {
            self.output?.didTapCancel()
        }
    }
}

extension AddListViewController: AddListViewInput {
    
}
