import SwiftUI

struct ShopDetailView: View {
    let shop: Shop

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("住所")
            Text(shop.address)
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
