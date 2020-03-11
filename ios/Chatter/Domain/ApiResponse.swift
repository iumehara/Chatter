import Foundation

struct ApiResponse<T: Codable>: Codable {
    var data: T
}
