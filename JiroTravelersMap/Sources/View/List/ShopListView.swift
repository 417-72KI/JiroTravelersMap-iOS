//
//  ShopListView.swift
//  JiroTravelersMap
//
//  Created by 417.72KI on 2020/01/31.
//

import SwiftUI

struct ShopListView: View {
    var shopList: [Shop]

    var body: some View {
        NavigationView {
            VStack {
                List(shopList) { shop in
                    NavigationLink(destination: ShopDetailView(shop: shop)) {
                        VStack(alignment: .leading) {
                            Text(shop.name)
                                .font(.title)
                            Text(shop.openingToday)
                                .font(.body)
                        }
                    }
                }
                .navigationBarTitle(R.string.content.shopList, displayMode: .inline)
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
