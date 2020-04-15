import XCTest
@testable import stodo

final class ListsConfiguratorTests: XCTestCase {
    
    func testThatScreenConfiguresCorrectly() {
        let controller = ListsConfigurator().configure()
        
        XCTAssertNotNil(controller.output, "ListsViewController output is nil after configuration")
        XCTAssertTrue(controller.output is ListsPresenter, "output is not ListsPresenter")
        
        guard let presenter = controller.output as? ListsPresenter else {
            XCTFail("Can't assign controller.output to ListPresenter")
            return
        }
        
        XCTAssertNotNil(presenter.view, "view in ListsPresenter is nil after configuration")
        XCTAssertTrue(presenter.view is ListsViewController, "view in presenter is not ListsViewController")
        
        XCTAssertNotNil(presenter.router, "router in ListsPresenter is nil after configuration")
        guard let router = presenter.router as? ListsRouter else {
            XCTFail("Can't assign presenter.router to ListsRouter")
            return
        }
        
        XCTAssertTrue(router.view is ListsViewController, "view in router is not ListsViewController")
        
        
        XCTAssertNotNil(presenter.service, "service in ListsPresenter is nil after configuration")
        XCTAssertTrue(presenter.service is ListsService, "service in ListsPresenter is not ListsService")
    }
}
