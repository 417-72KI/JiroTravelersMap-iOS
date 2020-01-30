import Rswift
import SwiftUI

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
