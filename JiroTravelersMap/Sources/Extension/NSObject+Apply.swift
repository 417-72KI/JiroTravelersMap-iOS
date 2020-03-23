import Foundation

protocol Applyable {}

extension Applyable {
    func apply(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}

extension NSObject: Applyable {
}
