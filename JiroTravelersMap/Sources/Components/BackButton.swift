import SwiftUI

struct BackButton: View {
    var label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "chevron.left")
                Text(label)
            }
        }
    }
}

#if DEBUG
struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton(label: "Back") {
        }
    }
}
#endif
