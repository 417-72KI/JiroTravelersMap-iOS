import SwiftUI

struct ShopDetailView: View {
    let shop: Shop

    @State private var showMap: Bool = false

    var body: some View {
        // swiftlint:disable:next closure_body_length
        VStack(alignment: .leading, spacing: 8) {
            NavigationLink(
                destination: ShopMapView(shopList: [shop])
                    .navigationBarBackButtonHidden(true)
                    .navigationBarItems(leading:
                        BackButton(label: shop.name) { self.showMap = false }
                ),
                isActive: $showMap,
                label: { EmptyView() }
            )
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("住所")
                    Text(shop.address)
                }
                Spacer()
                Button(action: { self.showMap = true },
                       label: { Image(R.image.ic_map) })
            }
            Divider()
            Text("定休日")
            Text(shop.regularHoliday.shortStringValue)
            Divider()
            Text("営業時間")
            Text(shop.openingHours.stringValue)
            Spacer()
        }.padding(20)
            .navigationBarTitle(shop.name)
            .navigationBarItems(trailing:
                Button(action: {
                    // TODO: New memory view
                },
                       label: { Image(R.image.ic_create) }
                )
        )
    }
}

#if DEBUG
struct ShopDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ShopDetailView(shop: Shop.mockList[0])
    }
}
#endif
