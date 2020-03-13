import Foundation
import Combine

final class GroupDetailScreenViewModel: ObservableObject {
    @Published var groupDetail: GroupDetail? = nil
    @Published var messages: [Message] = []
    @Published var title: String = "Loading Group..."
    
    private var groupId: UUID
    private var groupRepo: GroupRepo
    private var disposables = Set<AnyCancellable>()
    private var groupChannel: GroupChannel?
    
    init(groupId: UUID, groupRepo: GroupRepo) {
        self.groupId = groupId
        self.groupRepo = groupRepo
    }
    
    func onAppear() {
        self.groupChannel = GroupChannel(groupId: groupId)
        groupRepo.getDetail(groupId: groupId)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: {[weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure:
                        self.groupDetail = nil
                    case .finished:
                        break
                    }
                },
                receiveValue: {[weak self] receivedValue in
                    guard let self = self else { return}
                    self.groupDetail = receivedValue
                    self.messages = receivedValue.messages
                    self.title = receivedValue.name
                })
            .store(in: &disposables)
        
        groupChannel?.join()
        
        groupChannel?.on(callback: { message  in
            self.messages.append(message)
        })
    }
    
    func onDisappear() {
        groupChannel?.leave()
    }
}
