import Foundation

struct Message: Hashable, Codable, Identifiable {
    var id: UUID
    var content: String
    var username: String
}
