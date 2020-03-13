import SwiftUI

struct MessageRow: View {
    var message: Message
    
    struct MessageContent: View {
        var content: String
        
        var body: some View {
            Text(content)
                .padding(10.0)
                .background(Color.gray)
                .clipShape(RoundedShape(radius: 15, corners: [.topRight, .bottomLeft, .bottomRight]))
                
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(message.username) said ")
            HStack(alignment: .top) {
                Spacer().frame(width: 20)
                MessageContent(content: message.content)
            }
            .frame(alignment: .leading)
        }
    }
}

struct RoundedShape: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct MessageRow_Previews: PreviewProvider {
    static var previews: some View {
        let messageId = UUID(uuidString: "7bea2236-9372-4de9-a39a-f44a7b76f953")!
        return MessageRow(message: Message(id: messageId, content: "How's it going everyone. Let's plan a trip together. Where should we go? Any ideas?", username: "Bob"))
    }
}
