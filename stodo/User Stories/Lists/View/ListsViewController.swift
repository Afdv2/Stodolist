import UIKit
import Moya

class ListsViewController: UIViewController, ListsViewInput, ModuleTransitionable {
    
    var output: ListsViewOutput?
    
    static func create(nibName: String? = nil, bundle: Bundle? = nil) -> ListsViewController {
        if nibName == nil {
            let className = String(describing: ListsViewController.self)
            return ListsViewController(nibName: className, bundle: bundle)
        }
        
         return ListsViewController(nibName: nibName, bundle: bundle)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
