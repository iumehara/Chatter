import Foundation
import Combine

final class GroupRepo {
    func getList() -> AnyPublisher<[Group], ChatterError> {
        guard let url = URL(string: "http://localhost:4000/api/groups") else {
            return Fail(error: ChatterError()).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpBody = nil
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { error in
                ChatterError()
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                self.decodeGroups(pair.data)
            }
        .eraseToAnyPublisher()
    }

    func getDetail(groupId: UUID) -> AnyPublisher<GroupDetail, ChatterError> {
        let path = "http://localhost:4000/api/groups/" + groupId.uuidString
        guard let url = URL(string: path) else {
            return Fail(error: ChatterError()).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpBody = nil
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { error in
                ChatterError()
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                self.decodeGroupDetail(pair.data)
            }
        .eraseToAnyPublisher()
    }

    private func decodeGroups(_ data: Data) -> AnyPublisher<[Group], ChatterError> {
        let decoder = JSONDecoder()
                
      return Just(data)
        .decode(type: ApiResponse.self, decoder: decoder)
        .map { response in
            response.data
        }
        .mapError { error in
            ChatterError()
        }
        .eraseToAnyPublisher()
    }
    
    private func decodeGroupDetail(_ data: Data) -> AnyPublisher<GroupDetail, ChatterError> {
        let decoder = JSONDecoder()
                
      return Just(data)
        .decode(type: ApiResponse.self, decoder: decoder)
        .map { response in
            response.data
        }
        .mapError { error in
            ChatterError()
        }
        .eraseToAnyPublisher()
    }
}
