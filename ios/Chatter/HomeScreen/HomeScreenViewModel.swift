import Foundation
import Combine

final class HomeScreenViewModel: ObservableObject {
    @Published var groups: [Group] = []
    @Published var messages: [Message] = []

    private var groupRepo: GroupRepo
    private var disposables = Set<AnyCancellable>()

    init(groupRepo: GroupRepo) {
        self.groupRepo = groupRepo
    }
    
    func onAppear() {
        groupRepo.getList()
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: {[weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    self.groups = []
                case .finished:
                    break
                }
            },
            receiveValue: {[weak self] receivedValue in
                guard let self = self else { return}
                self.groups = receivedValue
            })
        .store(in: &disposables)
    }
}
