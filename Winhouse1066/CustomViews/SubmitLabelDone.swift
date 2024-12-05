import SwiftUI

struct SubmitLabelDone: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .submitLabel(.done)
        } else {
            content
        }
    }
}

extension View {
    public func submitLabelDone() -> some View {
        modifier(SubmitLabelDone())
    }
}
