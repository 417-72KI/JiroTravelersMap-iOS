//
//  ShopListView.swift
//  JiroTravelersMap
//
//  Created by 417.72KI on 2020/01/31.
//

import SwiftUI

struct ShopListView: View {
    @State var shopList: [Shop]

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
        ShopListView(shopList: shopList)
    }

    static var shopList: [Shop] {
        do {
            let data = try Data(resource: R.file.shopListJson)
            return try decoder.decode([Shop].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
}
#endif
