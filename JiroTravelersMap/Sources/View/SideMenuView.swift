import Foundation
import SwiftUI

struct SideMenuView: View {
    @EnvironmentObject private var sharedState: SharedState

    var body: some View {
        VStack {
            Toggle(isOn: $sharedState.displayOnlyOpeningShops) {
                Text("開店中のみ")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding(.top, 100)
            Spacer()
        }
        .padding()
        .background(Color(red: 32 / 255, green: 32 / 255, blue: 32 / 255))
        .edgesIgnoringSafeArea(.all)
    }
}
