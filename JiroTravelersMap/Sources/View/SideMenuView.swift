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
                SegmentedSelectionList(
                    selection: $sharedState.shopSortOrder,
                    label: Text(R.string.menu.sortOrder)
                        .foregroundColor(Color(UIColor.label))
                        .font(.headline)) {
                            ForEach(Shop.SortOrder.allCases, id: \.self) {
                                Text($0.label)
                            }
                }
                Divider()
                SegmentedSelectionList(
                    selection: $sharedState.maxDisplayCount,
                    label: Text(R.string.menu.displayCount)
                        .foregroundColor(Color(UIColor.label))
                        .font(.headline)) {
                            ForEach(SharedState.displayCountCandidates, id: \.self) {
                                $0 == .max
                                    ? Text(R.string.menu.all)
                                    : Text("\($0)")
                            }
                }
                Spacer()
            }
            .padding()
        }
        .compositingGroup()
        .border(Color.gray, width: 1)
        .edgesIgnoringSafeArea(.all)
        .alert(isPresented: $sharedState.showLocationError) {
            Alert(title: Text(R.string.alert.gps_on),
                  dismissButton: .default(Text(R.string.alert.ok)) { self.sharedState.shopSortOrder = .id })
        }
    }
}
