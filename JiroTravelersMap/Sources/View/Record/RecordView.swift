import SwiftUI

struct RecordView: View {
    @State var shop: Shop
    var shopList: [Shop]
    @State private var date = Date()

    var body: some View {
        NavigationView {
            Form {
                Picker(selection: $shop, label: Text("店舗")) {
                    ForEach(shopList, id: \.self) {
                        Text($0.name)
                    }
                }
                DatePicker(selection: $date,
                           in: ...Date(),
                           displayedComponents: [.date, .hourAndMinute]) {
                            Text("日付")
                }
            }.navigationBarTitle("行脚記録", displayMode: .inline)
        }
    }
}

#if DEBUG
struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(shop: Shop.mockList[0], shopList: Shop.mockList)
    }
}
#endif
