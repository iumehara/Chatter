import Foundation

struct Group: Hashable, Codable, Identifiable {
    var id: UUID
    var name: String
}

struct Message: Hashable, Codable, Identifiable {
    var id: UUID
    var content: String
    var username: String
}
