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
                    .navigationBarItems(trailing: Button(
                        action: {
                            withAnimation {
                                self.sharedState.showMenu.toggle()
                            }
                        },
                        label: {
                            Image(systemName: "ellipsis")
                                .imageScale(.large)
                        })
                    )
                }
                .frame(width: geometry.size.width,
                       height: geometry.size.height)
                HStack {
                    Spacer()
                    SideMenuView()
                        .environmentObject(self.sharedState)
                        .frame(width: geometry.size.width / 2,
                               alignment: .trailing)
                }
                .transition(.move(edge: .trailing))
                .offset(x: self.sharedState.showMenu ? 0 : geometry.size.width / 2)
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
