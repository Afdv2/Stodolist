import UIKit
import Moya

class ListsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let simpleStubProvider = MoyaProvider<ListsAPI>(stubClosure: MoyaProvider.delayedStub(1.0))
        let listsService = ListService(listsProvider: simpleStubProvider)
        listsService.getLists { result in
            switch result {
            case .success(let lists):
                print(lists)
            case .failure(let error):
                print(error)
            }
        }
    }

}
