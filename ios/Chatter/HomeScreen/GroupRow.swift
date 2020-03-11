import SwiftUI

struct GroupRow: View {
    var group: Group
    
    var body: some View {
        HStack {
            Text(group.name)
            Spacer()
        }
    }
}

struct GroupRow_Previews: PreviewProvider {
    static var previews: some View {
        let groupId = UUID(uuidString: "7bea2236-9372-4de9-a39a-f44a7b76f953")!
        return GroupRow(group: Group(id: groupId, name: "Other Planning"))
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
