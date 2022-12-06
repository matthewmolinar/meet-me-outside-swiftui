import Foundation

enum AppError: Error {
    // Throw when an expected resource is not found
    case error(message: String)
}

// For each error type return the appropriate description
extension AppError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .error(message: let message):
            return NSLocalizedString(
                message,
                comment: "Something went wrong"
            )
        }
    }
}
