//
//  ShopListView.swift
//  JiroTravelersMap
//
//  Created by 417.72KI on 2020/01/31.
//

import SwiftUI

struct ShopListView: View {
    @EnvironmentObject private var sharedState: SharedState

    var shopList: [Shop]

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    List(self.shopList) { shop in
                        NavigationLink(destination: ShopDetailView(shop: shop, shopList: self.shopList)) {
                            VStack(alignment: .leading) {
                                Text(shop.nameWithStatus)
                                    .font(.title)
                                Text(shop.openingToday)
                                    .font(.body)
                            }
                        }
                    }
                    .navigationBarTitle(R.string.content.shopList, displayMode: .inline)
                    .navigationBarItems(leading: Button(
                        action: {
                            withAnimation {
                                self.sharedState.showMenu.toggle()
                            }
                        },
                        label: {
                            Image(systemName: "line.horizontal.3")
                                .imageScale(.large)
                        })
                    )
                }
                .frame(width: geometry.size.width,
                       height: geometry.size.height)
                    .offset(x: self.sharedState.showMenu ? geometry.size.width / 2 : 0)
                if self.sharedState.showMenu {
                    SideMenuView()
                        .environmentObject(self.sharedState)
                        .frame(width: geometry.size.width / 2)
                        .transition(.move(edge: .leading))
                }
            }
        }
    }
}

#if DEBUG
struct ShopListView_Previews: PreviewProvider {
    static var previews: some View {
        ShopListView(shopList: Shop.mockList)
    }
}
#endif
