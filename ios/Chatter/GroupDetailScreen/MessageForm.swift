import SwiftUI

struct MessageForm: View {
    @ObservedObject var viewModel: GroupDetailScreenViewModel

    var body: some View {
        HStack(alignment: .bottom) {
            VStack {
                HStack {
                    Text("Username")
                    TextField(viewModel.username, text: $viewModel.username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                    MultilineTextView(text: $viewModel.messageContent)
                        .border(Color.black)
                        .frame(height: 50)
                        .font(.largeTitle)
            }
            Button(action: self.buttonClicked) {
                Text("SEND")
            }
        }
    }
    
    func buttonClicked() {
        print("clicked!")
    }
}

struct MessageForm_Previews: PreviewProvider {
    static var previews: some View {
        let groupId = UUID(uuidString: "7bea2236-9372-4de9-a39a-f44a7b76f953")!
        let viewModel = GroupDetailScreenViewModel(groupId: groupId, groupRepo: GroupRepo())

        return MessageForm(viewModel: viewModel)
    }
}
