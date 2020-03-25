//
//  ContentView.swift
//  JiroTravelersMap
//
//  Created by 417.72KI on 2020/01/29.
//  Copyright © 2020 417.72KI. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    @EnvironmentObject var sharedState: SharedState
    @ObservedObject var viewModel: ContentViewModel

    var body: some View {
        ZStack {
            TabView(selection: self.$selection) {
                ShopListView(shopList: self.filteredShopList)
                    .tabItem {
                        VStack {
                            Image(R.image.ic_list)
                            Text(R.string.content.shopList)
                        }
                    }
                .environmentObject(self.sharedState)
                .tag(0)
                ShopMapView(shopList: self.filteredShopList)
                    .tabItem {
                        VStack {
                            Image(R.image.ic_location)
                            Text(R.string.content.map)
                        }
                    }
                .environmentObject(self.sharedState)
                .tag(1)
            }
        }.onAppear(perform: viewModel.fetch)
    }
}

// MARK: -
private extension ContentView {
    var filteredShopList: [Shop] {
        viewModel.shopList.lazy
            .filter { [sharedState] in
                sharedState.displayOnlyOpeningShops
                    ? $0.isOpening(on: Date())
                    : true
            }
            .sorted(by: sharedState.shopSortOrder, location: sharedState.location)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: MockContentViewModel())
            .environmentObject(SharedState())
    }
}
#endif
