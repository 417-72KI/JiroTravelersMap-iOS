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
                Divider()
                List(shopList) { shop in
                    Text(shop.name)
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
