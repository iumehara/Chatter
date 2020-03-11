import ViewInspector
@testable import Chatter

extension GroupRow: Inspectable {}

struct GroupRowHelper {
    private var sut: GroupRow
    
    init(sut: GroupRow) {
        self.sut = sut
    }
    
    func getString() throws -> String? {
        return try sut.inspect().hStack().text(0).string()
    }
}
