//
//  ShopMapView.swift
//  JiroTravelersMap
//
//  Created by 417.72KI on 2020/01/31.
//

import SwiftUI

struct ShopMapView: View {
    var shopList: [Shop]

    var body: some View {
        NavigationView {
            MapView(annotations: shopList.map(ShopAnnotation.init))
        }
    }
}

#if DEBUG
struct ShopMapView_Previews: PreviewProvider {
    static var previews: some View {
        ShopMapView(shopList: Shop.mockList)
    }
}
#endif
