import Foundation
import Combine

enum AppError: LocalizedError {
    case apiError(APIError)
    case unexpected(origin: Error)
}

// MARK: -
enum APIError: LocalizedError {
    case invalidResponse
    case invalidResponseStatus(code: Int)
}

// MARK: -
extension Error {
    func asAppError() -> AppError {
        switch self {
        case let apiError as APIError:
            return .apiError(apiError)
        default:
            return .unexpected(origin: self)
        }
    }
}
