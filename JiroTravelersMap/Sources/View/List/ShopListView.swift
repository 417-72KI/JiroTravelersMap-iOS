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
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(shop.nameWithStatus)
                                        .font(.title)
                                    Text(shop.openingToday)
                                        .font(.body)
                                }
                                Spacer()
                                self.sharedState.location
                                    .flatMap(shop.location.distance)
                                    .flatMap { Text(String(format: "%.2f km", $0 / 1000)) }
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
        }.gesture(
            DragGesture()
                .onEnded {
                    switch $0.translation.width {
                    case ..<(-100):
                        withAnimation {
                            self.sharedState.showMenu = true
                        }
                    case 100...:
                        withAnimation {
                            self.sharedState.showMenu = false
                        }
                    default:
                        break
                    }
                }
        )
    }
}

#if DEBUG
struct ShopListView_Previews: PreviewProvider {
    static var previews: some View {
        ShopListView(shopList: Shop.mockList)
    }
}
#endif
