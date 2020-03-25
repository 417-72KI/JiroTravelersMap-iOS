import Foundation
import SwiftUI

struct SideMenuView: View {
    @EnvironmentObject private var sharedState: SharedState

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(UIColor.tertiarySystemBackground).opacity(0.6))
                .blur(radius: 5)
            VStack {
                Toggle(isOn: $sharedState.displayOnlyOpeningShops) {
                    Text(R.string.menu.onlyOpen)
                        .foregroundColor(Color(UIColor.label))
                        .font(.headline)
                }
                .padding(.top, 100)
                Divider()
                Spacer()
            }
            .padding()
        }
        .compositingGroup()
        .border(Color.gray, width: 1)
        .edgesIgnoringSafeArea(.all)
    }
}
