import SwiftUI

struct ShopDetailView: View {
    let shop: Shop

    var body: some View {
        NavigationView {
            VStack {
                Text("住所")
                Text(shop.address)
                Divider()
                Text("定休日")
                Text(shop.regularHoliday.shortStringValue)
                Divider()
                Text("営業時間")
                Text(shop.openingHours.stringValue)
                Divider()
            }
        }.navigationBarTitle(shop.name)
            .navigationBarItems(trailing:
                Button(action: {
                }) { Image(R.image.ic_create)
                }
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
