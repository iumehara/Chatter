import Foundation
import SwiftPhoenixClient

final class GroupChannel {
    private var socket: Socket
    private var channel: Channel?
    private var groupId: UUID
    
    init(groupId: UUID) {
        self.groupId = groupId
        self.socket = Socket("ws://localhost:4000/socket")
        self.socket.connect()
    }
    
    func join() {
        self.channel = socket.channel("group:\(groupId.description.lowercased())")
        channel?.join()
            .receive("ok") { payload in print("joined!", payload)}
            .receive("error") { payload in print("Failed to join", payload) }
            .receive("timeout") { payload in print("Networking issue...", payload) }
    }

    func on(callback: @escaping (Chatter.Message) -> Void) {
        self.channel?.on("shout") { [weak self] spcMessage in
            guard let self = self,
                let body = spcMessage.payload["body"] as? [String:Any],
                let message = self.initMessage(from: body) else { return }
            
            callback(message)
        }
    }

    func leave() {
        channel?.leave()
            .receive("ok") { _ in  print("left")  }
    }
    
    private func initMessage(from body: [String: Any]) -> Message? {
        guard let idString = body["id"] as? String,
            let content = body["content"] as? String,
            let username = body["username"] as? String,
            let id = UUID(uuidString: idString) else { return nil }
        
        return Chatter.Message(id: id,
                               content: content,
                               username: username)
    }
}
