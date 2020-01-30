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

    var body: some View {
        TabView(selection: $selection) {
            ShopListView()
                .tabItem {
                    VStack {
                        Image(R.image.ic_list)
                        Text(R.string.content.shopList)
                    }
                }
            .tag(0)
            MapView()
                .tabItem {
                    VStack {
                        Image(R.image.ic_location)
                        Text(R.string.content.map)
                    }
                }
            .tag(1)
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
