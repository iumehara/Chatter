import Foundation

struct Group: Hashable, Codable, Identifiable {
    var id: UUID
    var name: String
}

struct GroupDetail: Hashable, Codable, Identifiable {
    var id: UUID
    var name: String
    var messages: [Message]
}
