import SwiftUI

struct RecordView: View {
    @ObservedObject private var viewModel: RecordViewModel

    var body: some View {
        NavigationView {
            Form {
                Picker(selection: $viewModel.form.shop, label: Text("店舗")) {
                    ForEach(viewModel.shopList, id: \.self) {
                        Text($0.name)
                    }
                }
                DatePicker(selection: $viewModel.form.date,
                           in: ...Date(),
                           displayedComponents: [.date, .hourAndMinute]) {
                            Text("日付")
                }
            }.navigationBarTitle("行脚記録", displayMode: .inline)
                .navigationBarItems(
                    trailing: Button(action: { self.submit() },
                                     label: { Text("記録する") }))
        }
    }
}

extension RecordView {
    init(shop: Shop, shopList: [Shop]) {
        viewModel = RecordViewModel(shop: shop, shopList: shopList)
    }
}

private extension RecordView {
    func submit() {
        print(viewModel.form)
    }
}

#if DEBUG
struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(shop: Shop.mockList[0], shopList: Shop.mockList)
    }
}
#endif
