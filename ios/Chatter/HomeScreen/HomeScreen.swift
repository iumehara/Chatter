import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var viewModel: HomeScreenViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.groups) { group in
                    NavigationLink(destination:
                        GroupDetailScreen(groupId: group.id)
                            .environmentObject(GroupDetailScreenViewModel(groupId: group.id, groupRepo: GroupRepo()))

                    ) {
                        GroupRow(group: group)
                    }
                }
            }
            .navigationBarTitle(Text("My Chat Groups"))
        }
        .onAppear(perform: fetchData)
    }
    
    private func fetchData() {
        viewModel.loadData()
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
            .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
            .environmentObject(HomeScreenViewModel(groupRepo: GroupRepo()))
    }
}