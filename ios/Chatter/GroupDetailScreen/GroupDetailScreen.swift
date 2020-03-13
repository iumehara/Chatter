import SwiftUI

struct GroupDetailScreen: View {
    @EnvironmentObject var viewModel: GroupDetailScreenViewModel
    @ObservedObject var keyboardHelper: KeyboardHelper = KeyboardHelper()
    
    init() {
        UITableView.appearance().separatorColor = .clear
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text(viewModel.title)
                List {
                    ForEach(viewModel.messages) { message in
                        MessageRow(message: message)
                    }
                }

                MessageForm(viewModel: viewModel)
            }
            .padding(.bottom, keyboardHelper.height)
        }
        .onAppear(perform: viewModel.onAppear)
        .onDisappear(perform: viewModel.onDisappear)
    }
}

struct GroupDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        let groupId = UUID(uuidString: "7bea2236-9372-4de9-a39a-f44a7b76f953")!
        let viewModel = GroupDetailScreenViewModel(groupId: groupId, groupRepo: GroupRepo())
        return GroupDetailScreen().environmentObject(viewModel)
    }
}
