import SwiftUI

struct GroupDetailScreen: View {
    @EnvironmentObject var viewModel: GroupDetailScreenViewModel
    var groupId: UUID
    
    var body: some View {
        NavigationView {
            if viewModel.groupDetail != nil {
                VStack {
                    Text(viewModel.groupDetail!.name)
                    List {
                        ForEach(viewModel.groupDetail!.messages) { message in
                            HStack {
                                Text(message.content)
                                Spacer()
                            }
                        }
                    }
                    Spacer()
                }

            } else {
                Text("Loading...")
                Spacer()
            }

        }
        .onAppear(perform: fetchData)
    }
    
    private func fetchData() {
        viewModel.loadData()
    }
}

struct GroupDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        let groupId = UUID(uuidString: "7bea2236-9372-4de9-a39a-f44a7b76f953")!
        return GroupDetailScreen(groupId: groupId)
        .environmentObject(GroupDetailScreenViewModel(groupId: groupId, groupRepo: GroupRepo()))
    }
}
