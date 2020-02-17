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

// MARK: -
extension Publisher where Self.Failure == Never {
    func bind(to relays: CurrentValueRelay<Output>...) -> AnyCancellable {
        bind(to: relays)
    }

    func bind(to relays: CurrentValueRelay<Output?>...) -> AnyCancellable {
        map { $0 as Output? }.bind(to: relays)
    }

    private func bind(to relays: [CurrentValueRelay<Output>]) -> AnyCancellable {
        sink { value in
            relays.forEach { $0.accept(value) }
        }
    }

    func bind(to relays: PassthroughRelay<Output>...) -> AnyCancellable {
        bind(to: relays)
    }

    func bind(to relays: PassthroughRelay<Output?>...) -> AnyCancellable {
        map { $0 as Output? }.bind(to: relays)
    }

    private func bind(to relays: [PassthroughRelay<Output>]) -> AnyCancellable {
        sink { value in
            relays.forEach { $0.accept(value) }
        }
    }
}
