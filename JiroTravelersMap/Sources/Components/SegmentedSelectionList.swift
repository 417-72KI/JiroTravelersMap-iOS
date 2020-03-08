import SwiftUI

struct SegmentedSelectionList<Label, SelectionValue, Content>: View where Label: View, SelectionValue: Hashable, Content: View {
    init(selection: Binding<SelectionValue>, label: Label, @ViewBuilder content: @escaping () -> Content) {
        self.selection = selection
        self.label = label
        self.content = content
    }

    private var selection: Binding<SelectionValue>
    private var label: Label
    private var content: () -> Content

    var body: some View {
        VStack {
            HStack {
                label
                Spacer()
            }
            Picker(selection: selection, label: Text(""), content: content)
                .labelsHidden()
        }.pickerStyle(SegmentedPickerStyle())
    }
}
