import Rswift
import SwiftUI

// MARK: -
extension View {
    @available(OSX, unavailable)
    public func navigationBarTitle(_ resource: StringResourceType) -> some View {
        navigationBarTitle(Text(resource))
    }

    @available(OSX, unavailable)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public func navigationBarTitle(_ resource: StringResourceType,
                                   displayMode: NavigationBarItem.TitleDisplayMode) -> some View {
        navigationBarTitle(Text(resource), displayMode: displayMode)
    }
}

// MARK: -
extension Text {
    init(_ resource: StringResourceType) {
        self.init(.init(resource.key), tableName: resource.tableName, bundle: resource.bundle)
    }
}

// MARK: -
extension Image {
    init(_ resource: ImageResourceType) {
        self.init(resource.name, bundle: resource.bundle)
    }
}
