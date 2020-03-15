import SwiftUI

protocol MultipleSelectable: Hashable, Identifiable {
    var label: String { get }

    init(label: String)
}

// MARK: -
struct MultipleSelectionList<SelectionValue>: View where SelectionValue: MultipleSelectable {
    @Binding private var selection: [SelectionValue]
    @Binding private var items: [SelectionValue]
    private let label: Text
    private let onCommit: () -> Void

    @State private var sheetPresenting: Bool = false

    init(selection: Binding<[SelectionValue]>,
         items: Binding<[SelectionValue]>,
         label: Text,
         onCommit: @escaping () -> Void = {}) {
        self._selection = selection
        self._items = items
        self.label = label
        self.onCommit = onCommit
    }

    var body: some View {
        VStack {
            Button(action: { self.sheetPresenting.toggle() }) {
                HStack {
                    label.foregroundColor(Color.primary)
                    Spacer()
                    Text("\(selection.count)")
                        .foregroundColor(Color(UIColor.systemGray))
                        .font(.body)
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color(UIColor.systemGray4))
                        .font(Font.body.weight(.medium))
                }
            }.sheet(isPresented: $sheetPresenting) {
                SelectionView(label: self.label,
                              items: self._items,
                              selections: self._selection,
                              onCommit: self.onCommit)
            }
        }
    }
}

// MARK: -
private extension MultipleSelectionList {
    struct SelectionView<SelectionValue>: View where SelectionValue: MultipleSelectable {
        private let label: Text
        @Binding private var items: [SelectionValue]
        @Binding private var selections: [SelectionValue]
        private let onCommit: () -> Void
        @State private var newItem: String = ""

        @Environment(\.presentationMode) var presentationMode

        init(label: Text,
             items: Binding<[SelectionValue]>,
             selections: Binding<[SelectionValue]>,
             onCommit: @escaping () -> Void) {
            self.label = label
            self._items = items
            self._selections = selections
            self.onCommit = onCommit
        }

        var body: some View {
            NavigationView {
                List {
                    Section(header: EmptyView()) {
                        ForEach(items) { item in
                            Row(title: item.label, isSelected: self.selections.contains(item)) {
                                if self.selections.contains(item) {
                                    self.selections.removeAll(where: { $0 == item })
                                } else {
                                    self.selections.append(item)
                                }
                            }
                        }
                    }
                    Section(header: EmptyView()) {
                        TextField("新しいアイテムを追加",
                                  text: $newItem,
                                  onEditingChanged: {
                                    if $0 { return }
                                    let newValue = SelectionValue(label: self.newItem)
                                    self.items.append(newValue)
                                    self.selections.append(newValue)
                                    self.newItem = ""
                        })
                    }
                }
                    .listStyle(GroupedListStyle())
                    .navigationBarTitle(label, displayMode: .inline)
                    .navigationBarItems(trailing:
                        Button(action: {
                            self.onCommit()
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("OK")
                        })
                )
            }
        }
    }
}

private extension MultipleSelectionList.SelectionView {
    struct Row: View {
        var title: String
        var isSelected: Bool
        var action: () -> Void

        var body: some View {
            Button(action: action) {
                HStack {
                    Text(title)
                        .foregroundColor(Color.primary)
                    if isSelected {
                        Spacer()
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
            }.foregroundColor(Color.black)
        }
    }
}
