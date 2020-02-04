import Foundation
import Combine

protocol Relay: Publisher where Failure == Never {
    func accept(_ event: Self.Output)
}

// MARK: -
final class PassthroughRelay<Output>: Relay {
    private let subject = PassthroughSubject<Output, Never>()

    init() {}

    func accept(_ event: Output) {
        subject.send(event)
    }

    func receive<S>(subscriber: S) where S: Subscriber, S.Failure == Never, Output == S.Input {
        subject.receive(subscriber: subscriber)
    }
}

// MARK: -
final class CurrentValueRelay<Output>: Relay {
    private let subject: CurrentValueSubject<Output, Never>

    var value: Output { subject.value }

    init(_ value: Output) {
        subject = CurrentValueSubject(value)
    }

    func accept(_ event: Output) {
        subject.send(event)
    }

    func receive<S>(subscriber: S) where S: Subscriber, S.Failure == Never, Output == S.Input {
        subject.receive(subscriber: subscriber)
    }
}
