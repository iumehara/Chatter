import SwiftUI

struct MultilineTextView: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.font = .systemFont(ofSize: 20)
        return view
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}

struct MultilineTextView_Previews: PreviewProvider {
    struct BindingTestHolder: View {
        @State var text = "hello"
        var body: some View {
            MultilineTextView(text: $text)
        }
    }
    
    static var previews: some View {
        BindingTestHolder()
    }
}
