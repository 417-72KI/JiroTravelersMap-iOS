import Foundation

extension Sequence {
    public func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        sorted { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }

    public func sorted<T: Comparable>(by keyPath: KeyPath<Element, T?>) -> [Element] {
        sorted {
            guard let lValue = $0[keyPath: keyPath],
                let rValue = $1[keyPath: keyPath] else { return false }
            return lValue < rValue
        }
    }
}
