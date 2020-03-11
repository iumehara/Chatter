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

        let session = URLSession.shared
        
        return session.dataTaskPublisher(for: request)
            .mapError { error in
                ChatterError()
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                self.decode(pair.data)
            }
        .eraseToAnyPublisher()
    }
    
    private func decode(_ data: Data) -> AnyPublisher<[Group], ChatterError> {
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
