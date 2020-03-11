import XCTest
import ViewInspector
@testable import Chatter

//extension GroupRow: Inspectable {}

class ChatterTests: XCTestCase {

    func testExample() throws {
        
        let groupId = UUID(uuidString: "7bea2236-9372-4de9-a39a-f44a7b76f953")!
        let sut = GroupRow(group: Group(id: groupId, name: "Other Planning"))
        
//        let value = try sut.inspect().hStack().text(0).string()!
        
        let value = try GroupRowHelper(sut: sut).getString()
        
        
        XCTAssertEqual(value, "Other Planning")
    }
}
