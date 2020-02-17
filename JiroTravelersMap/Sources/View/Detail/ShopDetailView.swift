import SwiftUI

struct ShopDetailView: View {
    let shop: Shop

    @State private var showRecord: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("住所")
                    Text(shop.address)
                }
                Spacer()
                NavigationLink(destination: ShopDetailMapView(shop: shop),
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
                Button(action: { self.showRecord = true },
                       label: { Image(R.image.ic_create) })
                    .sheet(isPresented: $showRecord) { RecordView(shop: self.shop) }
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
