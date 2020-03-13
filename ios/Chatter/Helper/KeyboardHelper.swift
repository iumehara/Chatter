import Foundation
import Combine
import UIKit

final class KeyboardHelper: ObservableObject {
    @Published private(set) var height: CGFloat
    private var notificationCenter: NotificationCenter

    init() {
        self.height = 0
        self.notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(self.keyBoardWillShow),
                                       name: UIResponder.keyboardWillShowNotification,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(self.keyBoardWillHide),
                                       name: UIResponder.keyboardWillHideNotification,
                                       object: nil)
    }
    
    @objc func keyBoardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            height = keyboardSize.height
        }
    }

    @objc func keyBoardWillHide(_ notification: Notification) {
        height = 0
    }
}
