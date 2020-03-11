import Foundation
import Combine

final class GroupDetailScreenViewModel: ObservableObject {
    @Published var groupDetail: GroupDetail? = nil
    
    private var groupId: UUID
    private var groupRepo: GroupRepo
    private var disposables = Set<AnyCancellable>()
    
    init(groupId: UUID, groupRepo: GroupRepo) {
        self.groupId = groupId
        self.groupRepo = groupRepo
    }
    
    func loadData() {
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
                })
            .store(in: &disposables)
    }
}
